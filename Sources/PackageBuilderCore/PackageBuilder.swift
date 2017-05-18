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
        print("Welcome to the PackageBuilder that builds a command line tool using the Swift Package Manager")
        print(".")
        print("├── {$PROJECT_NAME}.xcodeproj")
        print("├── Package.swift")
        print("├── Sources")
        print("│   ├── {$PROJECT_NAME}")
        print("│   │   └── main.swift")
        print("│   └── {$PROJECT_NAME}Core")
        print("│       └── {$PROJECT_NAME}.swift")
        print("└── Tests")
        print("     └── {$PROJECT_NAME}Tests")
        print("         └── {$PROJECT_NAME}Tests.swift")
        print("Based on https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager")

        guard arguments.count == 2 else {
            print("Please add your command line tool name. ex. `PackageBuilder {PROJECT_NAME}`")
            return
        }

        let projectName = arguments[1]

        let folder = try FileSystem().createFolder(at: projectName)
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


        let tempFolder = try FileSystem().createFolder(at: "temp")
        print("Cloning PackageBulder by HTTPS to get files in Templates...")
        // try shellOut(to: "git clone https://github.com/pixyzehn/PackageBuilder.git temp -q")

        print("Renaming {PACKAGE_NAME} to \(projectName)...")
        try replaceAllFilesOfContentInFolder(oldName: "{PROJECT_NAME}", newName: "\(projectName)", at: "temp/Templates")

        print("Moving files in Templates to a correct position...")
        try tempFolder.subfolder(named: "Templates").file(named: "main.swift").move(to: sourcesProjectFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "Package.swift").move(to: folder)
        try tempFolder.subfolder(named: "Templates").file(named: "\(projectName).swift").move(to: sourcesProjectCoreFolder)
        try tempFolder.subfolder(named: "Templates").file(named: "\(projectName)Tests.swift").move(to: projectTestsFolder)

        print("Deleting temp folder...")
        // try tempFolder.delete()

        print("Executing `swift build` & `swift test --parallel`")
        try shellOut(to: "cd \(projectName) && swift build && swift test --parallel")

        print("Generating xcodeproj...")
        try shellOut(to: "cd \(projectName) && swift package generate-xcodeproj")
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
