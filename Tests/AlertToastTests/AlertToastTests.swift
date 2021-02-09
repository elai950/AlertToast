import XCTest
@testable import AlertToast

final class AlertToastTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AlertToast().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
