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
    
    func test_init_animalHasStartDateBefore1983() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
        XCTAssertNotNil(sut.animals.first?.startDateBefore1983)
    }
    
    func test_init_firstRecordStartDateBefore1983_isCorrect() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
        
        let expectedDate = chineseDate(from: "1924-02-05")
        
        XCTAssertEqual(sut.animals.first?.startDateBefore1983, expectedDate)
    }
    
    func test_init_firstRecordEndDateBefore1983_isCorrect() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
                
        let expectedDate = chineseDate(from: "1925-01-23")
        
        XCTAssertEqual(sut.animals.first?.endDateBefore1983, expectedDate)
    }
    
    func test_init_firstRecordStartDateAfter1984_isCorrect() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
        
        let expectedDate = chineseDate(from: "1984-02-02")
        
        XCTAssertEqual(sut.animals.first?.startDateAfter1984, expectedDate)
    }
    
    func test_init_firstRecordEndDateAfter1984_isCorrect() {
        let records: [WikipediaLine] = JSONFileReader().load()
        let sut = Transmogrifier(records)
        
        let expectedDate = chineseDate(from: "1985-02-19")
        
        XCTAssertEqual(sut.animals.first?.endDateAfter1984, expectedDate)
    }
    
    // MARK: - Helpers
    
    fileprivate func chineseDate(from str: String) -> Date {
        let formatter = DateFormatter.chineseDateFormatter()
        guard let date = formatter.date(from: str) else { fatalError() }
        return date
    }
}
