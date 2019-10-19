import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase({PACKAGE_NAME}Tests.allTests),
    ]
}
#endif
