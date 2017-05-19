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
    private let projectName = "SamplePackage"
    private let packageBuilderTests = ".PackageBuilderTests"

    override func setUp() {
        super.setUp()
        // Reset the test folder just in case.
        try? Folder.home.subfolder(named: packageBuilderTests).delete()

        folder = try! Folder.home.createSubfolder(named: packageBuilderTests)

        // Delete the {PACKAGE_NAME} directory if needed.
        try? folder.subfolder(named: "\(projectName)").delete()
    }

    override func tearDown() {
        try! folder.delete()
        super.tearDown()
    }

    func testCreatingPackage() {
        try! PackageBuilder(arguments: ["packagebuilder", projectName, "--path", "~/\(packageBuilderTests)"]).run()

        let projectFolder = try! folder.subfolder(named: "\(projectName)")

        // Ensure it creates needed files and folders under the {PACKAGE_NAME}.
        XCTAssertTrue(projectFolder.containsFile(named: "LICENSE"))
        XCTAssertTrue(projectFolder.containsFile(named: "Package.swift"))
        XCTAssertTrue(projectFolder.containsFile(named: "README.md"))
        XCTAssertTrue(projectFolder.containsSubfolder(named: "\(projectName).xcodeproj"))
        XCTAssertTrue(projectFolder.containsSubfolder(named: "Sources"))
        XCTAssertTrue(projectFolder.containsSubfolder(named: "Tests"))

        let sourcesFolder = try! projectFolder.subfolder(named: "Sources")
        let projectNameFolder = try! sourcesFolder.subfolder(named: "\(projectName)")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Sources/{PACKAGE_NAME}.
        XCTAssertTrue(projectNameFolder.containsFile(named: "main.swift"))

        let projectNameCoreFolder = try! sourcesFolder.subfolder(named: "\(projectName)Core")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Sources/{PACKAGE_NAME}Core.
        XCTAssertTrue(projectNameCoreFolder.containsFile(named: "\(projectName).swift"))

        let testsFolder = try! projectFolder.subfolder(named: "Tests")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Tests/LinuxMain.swift.
        XCTAssertTrue(testsFolder.containsFile(named: "LinuxMain.swift"))

        let projectTestsFolder = try! testsFolder.subfolder(named: "\(projectName)Tests")

        // Ensure it creates a needed file under the {PACKAGE_NAME}/Tests/{PACKAGE_NAME}Tests.
        XCTAssertTrue(projectTestsFolder.containsFile(named: "\(projectName)Tests.swift"))
    }
}

extension PackageBuilderTests {
    static var allTests : [(String, (PackageBuilderTests) -> () throws -> Void)] {
        return [
            ("testCreatingPackage", testCreatingPackage),
        ]
    }
}
