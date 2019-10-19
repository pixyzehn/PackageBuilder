/**
 *  PackageBuilder
 *  Copyright (c) Hiroki Nagasawa 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import XCTest
import PackageBuilderCore
import Files
import ShellOut

class PackageBuilderTests: XCTestCase {
    private var folder: Folder!
    private let packageName = "SamplePackage"
    private let packageBuilderTests = ".PackageBuilderTests"

    override func setUp() {
        super.setUp()
        // Reset the test folder just in case.
        try? Folder.home.subfolder(named: packageBuilderTests).delete()

        folder = try? Folder.home.createSubfolder(named: packageBuilderTests)

        // Delete the {PACKAGE_NAME} directory if needed.
        try? folder.subfolder(named: "\(packageName)").delete()
    }

    override func tearDown() {
        try? folder.delete()
        super.tearDown()
    }

    func testCreatingPackage() throws {
        try PackageBuilder(arguments: ["packagebuilder", packageName, "--path", "~/\(packageBuilderTests)"]).run()

        let projectFolder = try folder.subfolder(named: "\(packageName)")

        // Ensure it creates needed files and folders under the {PACKAGE_NAME}/.
        XCTAssertTrue(projectFolder.containsFile(named: "Package.swift"))
        XCTAssertTrue(projectFolder.containsFile(named: "README.md"))
        XCTAssertTrue(projectFolder.containsFile(named: "Makefile"))
        XCTAssertTrue(projectFolder.containsSubfolder(named: "\(packageName).xcodeproj"))
        XCTAssertTrue(projectFolder.containsSubfolder(named: "Sources"))
        XCTAssertTrue(projectFolder.containsSubfolder(named: "Tests"))

        // Ensure all `{}` are replaced for sure under the {PACKAGE_NAME}/.
        for file in projectFolder.files {
            try checkIfAllTempNamesReplaced(file: file)
        }

        let sourcesFolder = try projectFolder.subfolder(named: "Sources")

        let projectNameFolder = try sourcesFolder.subfolder(named: "\(packageName)")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Sources/{PACKAGE_NAME}/.
        XCTAssertTrue(projectNameFolder.containsFile(named: "main.swift"))

        // Ensure all `{}` are replaced for sure under the {PACKAGE_NAME}/Sources/{PACKAGE_NAME}/.
        if let file = projectNameFolder.files.first {
            try checkIfAllTempNamesReplaced(file: file)
        }

        let projectNameCoreFolder = try sourcesFolder.subfolder(named: "\(packageName)Core")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Sources/{PACKAGE_NAME}Core/.
        XCTAssertTrue(projectNameCoreFolder.containsFile(named: "\(packageName).swift"))

        // Ensure all `{}` are replaced for sure under the {PACKAGE_NAME}/Sources/{PACKAGE_NAME}Core/.
        if let file = projectNameCoreFolder.files.first {
            try checkIfAllTempNamesReplaced(file: file)
        }

        let testsFolder = try projectFolder.subfolder(named: "Tests")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Tests/.
        XCTAssertTrue(testsFolder.containsFile(named: "LinuxMain.swift"))

        // Ensure all `{}` are replaced for sure under the {PACKAGE_NAME}/Tests/.
        if let file = testsFolder.files.first {
            try checkIfAllTempNamesReplaced(file: file)
        }

        let projectTestsFolder = try testsFolder.subfolder(named: "\(packageName)Tests")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Tests/{PACKAGE_NAME}Tests/.
        XCTAssertTrue(projectTestsFolder.containsFile(named: "\(packageName)Tests.swift"))
        XCTAssertTrue(projectTestsFolder.containsFile(named: "XCTestManifests.swift"))

        // Ensure all `{}` are replaced for sure under the {PACKAGE_NAME}/Tests/{PACKAGE_NAME}Tests/.
        for file in projectTestsFolder.files {
            try checkIfAllTempNamesReplaced(file: file)
        }
    }

    // MARK: - Utilities

    private func checkIfAllTempNamesReplaced(file: File) throws {
        let contents = try file.readAsString(encodedAs: .utf8)
        XCTAssertFalse(contents.contains("{PACKAGE_NAME}"))
        XCTAssertFalse(contents.contains("{YOUR_NAME}"))
        XCTAssertFalse(contents.contains("{THIS_YEAR}"))
    }
}

extension PackageBuilderTests {
    static var allTests: [(String, (PackageBuilderTests) -> () throws -> Void)] {
        return [
            ("testCreatingPackage", testCreatingPackage)
        ]
    }
}
