import XCTest
import SexagenaryCycle1924

final class JSONFileReaderTests: XCTestCase {
    func test_load_givesModelRecords() {
        let sut = JSONFileReader()
        let records: [WikipediaLine] = sut.load()
        XCTAssertFalse(records.isEmpty)
    }
    
    func test_load_yieldsRecordWithAnAnimal() {
        let sut = JSONFileReader()
        let records: [WikipediaLine] = sut.load()
        XCTAssertFalse(records.first?.animal.isEmpty ?? true)
    }
}
