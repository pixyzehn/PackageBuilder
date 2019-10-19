import XCTest
import {PACKAGE_NAME}Tests

var tests = [XCTestCaseEntry]()
tests += {PACKAGE_NAME}Tests.allTests()
XCTMain(tests)
