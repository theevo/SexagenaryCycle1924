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
    
    func test_badDate_throwsError() {
        let lines: [WikipediaLine] = JSONFileReader().decode(string: jsonSampleBad())
        var thrownError: Error?
        
        XCTAssertThrowsError(try Transmogrifier(lines)) {
            thrownError = $0
        }
        
        guard let localError = thrownError as? Transmogrifier.TransmogrifierError else {
            XCTFail("Unexpected error type: \(type(of: thrownError))")
            return
        }
        
        guard case .failedToParseDate(_) = localError else {
            XCTFail("Expected \"failedToParseDate\" error, but was \(localError) instead.")
            return
        }
        
        XCTAssertTrue(true)
    }
    
    func test_dates_containsTwoDateRanges() {
        let lines: [WikipediaLine] = JSONFileReader().decode(string: jsonSample())
        
        guard let sut = try? Transmogrifier(lines) else {
            XCTFail("Failed to create Transmogrifier")
            return
        }
        
        guard let first = sut.animals.first else {
            XCTFail("Expected there to be animals but found 0 animals.")
            return
        }
        
        XCTAssertEqual(first.dates.count, 2)
    }
    
    // MARK: - Helpers
    
    fileprivate func buildSUT() -> Transmogrifier {
        let records: [WikipediaLine] = JSONFileReader().load()
        return try! Transmogrifier(records)
    }
    
    fileprivate func chineseDate(from str: String) -> Date {
        let formatter = DateFormatter.chineseDateFormatter()
        guard let date = formatter.date(from: str) else { fatalError() }
        return date
    }
    
    fileprivate func jsonSample() -> String {
        return
"""
[
  {
    "Line": "55",
    "Year 1924–1983": "Feb 07 1978–Jan 27 1979",
    "Year 1984–2043": "Feb 04 2038–Jan 23 2039",
    "Associated element": "Yang Earth",
    "Heavenly stem": "戊",
    "Earthly branch": "午",
    "Associated animal": "Horse"
  },
  {
    "Line": "57",
    "Year 1924–1983": "Feb 16 1980–Feb 04 1981",
    "Year 1984–2043": "Feb 12 2040–Jan 31 2041",
    "Associated element": "Yang Metal",
    "Heavenly stem": "庚",
    "Earthly branch": "申",
    "Associated animal": "Monkey"
  },
  {
    "Line": "2",
    "Year 1924–1983": "Jan 24 1925–Feb 12 1926",
    "Year 1984–2043": "Feb 20 1985–Feb 08 1986",
    "Associated element": "Yin Wood",
    "Heavenly stem": "乙",
    "Earthly branch": "丑",
    "Associated animal": "Ox"
  },
]
"""
    }
    
    fileprivate func jsonSampleBad() -> String {
        return
"""
[
  {
    "Line": "55",
    "Year 1924–1983": "Feb 07 1978–JA1348T439#$%#$SIEFJSDAFOIJ",
    "Year 1984–2043": "Feb 04 2038–Jan 23 2039",
    "Associated element": "Yang Earth",
    "Heavenly stem": "戊",
    "Earthly branch": "午",
    "Associated animal": "Horse"
  },
  {
    "Line": "57",
    "Year 1924–1983": "Feb 16 1980–Feb 04 1981",
    "Year 1984–2043": "Feb 12 2040–Jan 31 2041",
    "Associated element": "Yang Metal",
    "Heavenly stem": "庚",
    "Earthly branch": "申",
    "Associated animal": "Monkey"
  },
  {
    "Line": "2",
    "Year 1924–1983": "Jan 24 1925–Feb 12 1926",
    "Year 1984–2043": "Feb 20 1985–Feb 08 1986",
    "Associated element": "Yin Wood",
    "Heavenly stem": "乙",
    "Earthly branch": "丑",
    "Associated animal": "Ox"
  },
]
"""
    }
    
    fileprivate func jsonSampleEmpty() -> String {
        return "[]"
    }
}