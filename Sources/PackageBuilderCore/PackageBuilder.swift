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

    public func run() throws {
        guard arguments.count > 1 else {
            printDescription()
            return
        }

        let projectName = arguments[1]
        var folder = try FileSystem().createFolder(at: projectName)

        var expectingPath = false
        for argument in arguments[2..<arguments.count] {
            if expectingPath {
                try folder.delete()
                /// Use a given path for creating Package.
                folder = try Folder(path: argument).createSubfolder(named: projectName)
            }

            switch argument {
                case "--path":
                    expectingPath = true
                default:
                    expectingPath = false
                    continue
            }
        }

        print("Executing `swift package init --type executable`...")
        try shellOut(to: "swift package init --type executable", at: folder.path)

        let sourcesFolder = try folder.subfolder(atPath: "Sources")
        print("Creating Sources/\(projectName)...")
        let sourcesProjectFolder = try sourcesFolder.createSubfolder(named: projectName)
        print("Creating Sources/\(projectName)Core...")
        let sourcesProjectCoreFolder = try sourcesFolder.createSubfolder(named: projectName + "Core")

        let testsFolder = try folder.subfolder(atPath: "Tests")
        print("Creating Tests/\(projectName)Tests...")
        let projectTestsFolder = try testsFolder.createSubfolder(named: projectName + "Tests")

        print("Deleting original files created by SwiftPM...")
        try folder.file(named: "Package.swift").delete()
        try sourcesFolder.file(named: "main.swift").delete()

        let tempFolder = try folder.createSubfolder(named: "temp")
        print("Cloning PackageBulder by HTTPS to get files in Templates...")
        let packageBuilderGithubURL = "https://github.com/pixyzehn/PackageBuilder.git"
        try shellOut(to: "git clone \(packageBuilderGithubURL) \(folder.path)temp -q")

        print("Renaming {PROJECT_NAME} to \(projectName)...")
        try replaceAllFilesOfContentInFolder(oldName: "{PROJECT_NAME}", newName: "\(projectName)", at: "\(folder.path)temp/Templates")

        let userName = try shellOut(to: "git config user.name")
        print("Renaming {YOUR_NAME} to \(userName)...")
        try replaceAllFilesOfContentInFolder(oldName: "{YOUR_NAME}", newName: "\(userName)", at: "\(folder.path)temp/Templates")

        let thisYear = try shellOut(to: "date \"+%Y\"")
        print("Renaming {THIS_YEAR} to \(thisYear)...")
        try replaceAllFilesOfContentInFolder(oldName: "{THIS_YEAR}", newName: "\(thisYear)", at: "\(folder.path)temp/Templates")

        print("Moving files in Templates to a correct position...")
        try tempFolder.subfolder(named: "Templates").file(named: "Package.swift").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "LICENSE").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "README.md").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "main.swift").move(to: sourcesProjectFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "\(projectName).swift").move(to: sourcesProjectCoreFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "\(projectName)Tests.swift").move(to: projectTestsFolder)

        print("Deleting the temp folder...")
        try tempFolder.delete()

        print("Executing `swift build` & `swift test --parallel`")
        try shellOut(to: "swift build && swift test --parallel", at: folder.path)

        print("Generating xcodeproj...")
        try shellOut(to: "swift package generate-xcodeproj", at: folder.path)
    }

    // MARK: Private method

    private func printDescription() {
        print("PackageBuilder")
        print("--------------")
        print("PackageBuilder builds a simple command-line structure by SwiftPM.")
        print(".")
        print("├── {PROJECT_NAME}.xcodeproj")
        print("├── Package.swift")
        print("├── Sources")
        print("│   ├── {PROJECT_NAME}")
        print("│   │   └── main.swift")
        print("│   └── {PROJECT_NAME}Core")
        print("│       └── {PROJECT_NAME}.swift")
        print("└── Tests")
        print("    └── {PROJECT_NAME}Tests")
        print("        └── {PROJECT_NAME}Tests.swift")
        print("--------------")
        print("Based on https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager")
        print("Examples:")
        print("$ packagebuilder {PROJECT_NAME}")
    }

    private func replaceAllFilesOfContentInFolder(oldName: String, newName: String, at folderPath: String) throws {
        let fileManager = FileManager.default

        for fileName in try fileManager.contentsOfDirectory(atPath: folderPath) {
            if fileName.hasPrefix(".") {
                continue
            }
            let filePath = folderPath + "/" + fileName
            let newFilePath = folderPath + "/" + fileName.replacingOccurrences(of: oldName, with: newName)

            let fileContents = try String(contentsOfFile: filePath).replacingOccurrences(of: oldName, with: newName)
            try fileContents.write(toFile: newFilePath, atomically: false, encoding: .utf8)

            if newFilePath != filePath {
                try fileManager.removeItem(atPath: filePath)
            }
        }
    }
}
