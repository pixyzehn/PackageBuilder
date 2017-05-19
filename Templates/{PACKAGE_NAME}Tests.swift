/**
 *  {PACKAGE_NAME}
 *  Copyright (c) {YOUR_NAME} {THIS_YEAR}
 *  Licensed under the MIT license. See LICENSE file.
 */

import XCTest
import {PACKAGE_NAME}Core

class {PACKAGE_NAME}Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
    }
}

extension {PACKAGE_NAME}Tests {
    static var allTests : [(String, ({PACKAGE_NAME}Tests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
