//
//  TransmogrifierTests.swift
//  
//
//  Created by Theo Vora on 11/17/23.
//

import XCTest
import SexagenaryCycle1924

final class TransmogrifierTests: XCTestCase {
    func test_init_acceptsParamArrayOfWikipediaLines() {
        let sut = buildSUT()
        XCTAssertNotNil(sut.wikipedia)
    }
    
    func test_init_createsSexagenaryAnimal() {
        let sut = buildSUT()
        XCTAssertNotNil(sut.animals.first?.animal)
        XCTAssertNotNil(sut.animals.first?.element)
        XCTAssertNotNil(sut.animals.first?.heavenlyStem)
        XCTAssertNotNil(sut.animals.first?.earthlyBranch)
    }
    
    func test_init_animalHasStartDateBefore1983() {
        let sut = buildSUT()
        XCTAssertNotNil(sut.animals.first?.startDateBefore1983)
    }
    
    func test_init_firstRecordStartDateBefore1983_isCorrect() {
        let sut = buildSUT()
        
        let expectedDate = chineseDate(from: "1924-02-05")
        
        XCTAssertEqual(sut.animals.first?.startDateBefore1983, expectedDate)
    }
    
    func test_init_firstRecordEndDateBefore1983_isCorrect() {
        let sut = buildSUT()
                
        let expectedDate = chineseDate(from: "1925-01-23")
        
        XCTAssertEqual(sut.animals.first?.endDateBefore1983, expectedDate)
    }
    
    func test_init_firstRecordStartDateAfter1984_isCorrect() {
        let sut = buildSUT()
        
        let expectedDate = chineseDate(from: "1984-02-02")
        
        XCTAssertEqual(sut.animals.first?.startDateAfter1984, expectedDate)
    }
    
    func test_init_firstRecordEndDateAfter1984_isCorrect() {
        let sut = buildSUT()
        
        let expectedDate = chineseDate(from: "1985-02-19")
        
        XCTAssertEqual(sut.animals.first?.endDateAfter1984, expectedDate)
    }
    
    // MARK: - Helpers
    
    fileprivate func buildSUT() -> Transmogrifier {
        let records: [WikipediaLine] = JSONFileReader().load()
        return Transmogrifier(records)
    }
    
    fileprivate func chineseDate(from str: String) -> Date {
        let formatter = DateFormatter.chineseDateFormatter()
        guard let date = formatter.date(from: str) else { fatalError() }
        return date
    }
}
