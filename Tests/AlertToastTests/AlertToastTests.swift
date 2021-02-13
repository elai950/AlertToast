import XCTest
@testable import AlertToast

final class AlertToastTests: XCTestCase {
    
    func testInit() {
        let toast = AlertToast(type: .regular, title: "Title", subTitle: "Subtitle")
        XCTAssertEqual(toast.type, .regular)
        XCTAssertEqual(toast.title, "Title")
        XCTAssertEqual(toast.subTitle, "Subtitle")
    }

    static var allTests = [
        ("testInit", testInit),
    ]
}
