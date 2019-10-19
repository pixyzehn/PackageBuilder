/**
 *  PackageBuilder
 *  Copyright (c) Hiroki Nagasawa 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation
import Files
import ShellOut

public final class PackageBuilder {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    // swiftlint:disable function_body_length
    public func run() throws {
        guard arguments.count > 1 else {
            printDescription()
            return
        }

        let packageName = arguments[1]
        var folder = try Folder.home.createSubfolder(named: packageName)

        var expectingPath = false
        for argument in arguments[2..<arguments.count] {
            if expectingPath {
                try folder.delete()
                /// Use a given path for creating Package.
                folder = try Folder(path: argument).createSubfolder(named: packageName)
            }

            switch argument {
                case "--path":
                    expectingPath = true
                default:
                    expectingPath = false
                    continue
            }
        }

        print("Executing `swift package init --type empty` at \(folder.path)")
        try shellOut(to: "swift package init --type empty", at: folder.path)

        let sourcesFolder = try folder.subfolder(at: "Sources")

        print("Creating Sources/\(packageName)...")
        let sourcesProjectFolder = try sourcesFolder.createSubfolder(named: packageName)
        print("Creating Sources/\(packageName)Core...")
        let sourcesProjectCoreFolder = try sourcesFolder.createSubfolder(named: packageName + "Core")

        let testsFolder = try folder.subfolder(at: "Tests")
        print("Creating Tests/\(packageName)Tests...")
        let projectTestsFolder = try testsFolder.createSubfolder(named: packageName + "Tests")

        print("Deleting original files created by SwiftPM...")
        if folder.containsFile(named: "Package.swift") {
            try folder.file(named: "Package.swift").delete()
        }
        if folder.containsFile(named: "README.md") {
            try folder.file(named: "README.md").delete()
        }

        let tempFolder = try folder.createSubfolder(named: "temp")
        print("Cloning PackageBulder by HTTPS to get files in Templates...")
        let packageBuilderGithubURL = "https://github.com/pixyzehn/PackageBuilder.git"
        try shellOut(to: "git clone \(packageBuilderGithubURL) \(folder.path)temp -q")

        print("Renaming {PACKAGE_NAME} to \(packageName)...")
        try replaceAllFilesOfContentInFolder(oldName: "{PACKAGE_NAME}", newName: "\(packageName)", at: "\(folder.path)temp/Templates")

        print("Moving files in Templates to a correct position...")
        try tempFolder.subfolder(named: "Templates").file(named: "Package.swift").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "README.md").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "Makefile").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "main.swift").move(to: sourcesProjectFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "\(packageName).swift").move(to: sourcesProjectCoreFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "LinuxMain.swift").move(to: testsFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "\(packageName)Tests.swift").move(to: projectTestsFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "XCTestManifests.swift").move(to: projectTestsFolder)

        print("Deleting the temp folder...")
        try tempFolder.delete()

        print("Executing `swift build`")
        try shellOut(to: "swift build", at: folder.path)

        print("Generating xcodeproj...")
        try shellOut(to: "swift package generate-xcodeproj", at: folder.path)

        print("Enjoy \(packageName) 🎉")
    }

    // MARK: Private method

    private func printDescription() {
        print("PackageBuilder")
        print("--------------")
        print("PackageBuilder builds a simple command-line structure by SwiftPM.")
        print(".")
        print("├── LICENSE")
        print("├── Package.swift")
        print("├── README.md")
        print("├── Makefile")
        print("├── {PACKAGE_NAME}.xcodeproj")
        print("├── Sources")
        print("│   ├── {PACKAGE_NAME}")
        print("│   │   └── main.swift")
        print("│   └── {PACKAGE_NAME}Core")
        print("│       └── {PACKAGE_NAME}.swift")
        print("└── Tests")
        print("     ├── {PACKAGE_NAME}Tests")
        print("     │   ├── {PACKAGE_NAME}Tests.swift")
        print("     │   └── XCTestManifests.swift")
        print("     └── LinuxMain.swift")
        print("--------------")
        print("Examples:")
        print("- packagebuilder {PACKAGE_NAME}")
        print("- packagebuilder {PACKAGE_NAME} --path ~/Developer")
    }

    private func replaceAllFilesOfContentInFolder(oldName: String, newName: String, at folderPath: String) throws {
        let fileManager = FileManager.default

        for fileName in try fileManager.contentsOfDirectory(atPath: folderPath) {
            if fileName.hasPrefix(".") {
                continue
            }
            let filePath = folderPath + "/" + fileName
            let newFilePath = folderPath + "/" + fileName.replacingOccurrences(of: oldName, with: newName)

            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8).replacingOccurrences(of: oldName, with: newName)
            try fileContents.write(toFile: newFilePath, atomically: false, encoding: .utf8)

            if newFilePath != filePath {
                try fileManager.removeItem(atPath: filePath)
            }
        }
    }
}
