import XCTest
import SexagenaryCycle1924

final class SexagenaryCycle1924Tests: XCTestCase {
    func test_load_givesModelRecords() {
        let sut = FileHandler()
        let records: [[String: String]] = sut.load()
        XCTAssertFalse(records.isEmpty)
    }
}
