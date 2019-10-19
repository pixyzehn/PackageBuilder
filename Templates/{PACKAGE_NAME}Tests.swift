import XCTest
import {PACKAGE_NAME}Core

class {PACKAGE_NAME}Tests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension {PACKAGE_NAME}Tests {
    static var allTests: [(String, ({PACKAGE_NAME}Tests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
            ("testPerformanceExample", testPerformanceExample)
        ]
    }
}
