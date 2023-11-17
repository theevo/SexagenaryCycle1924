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

final class TransmogrifierTests: XCTestCase {
    func test_init_acceptsParamArrayOfWikipediaLines() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
        XCTAssertNotNil(sut.wikipedia)
    }
    
    func test_init_createsSexagenaryAnimal() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
        XCTAssertNotNil(sut.animals.first?.animal)
        XCTAssertNotNil(sut.animals.first?.element)
        XCTAssertNotNil(sut.animals.first?.heavenlyStem)
        XCTAssertNotNil(sut.animals.first?.earthlyBranch)
    }
}
