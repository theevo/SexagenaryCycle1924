//
//  TransmogrifierTests.swift
//  
//
//  Created by Theo Vora on 11/17/23.
//

import XCTest
import SexagenaryCycle1924

final class TransmogrifierTests: XCTestCase {
    func test_init_acceptsParamArrayOfWikipediaLines() throws {
        let sut = try buildSUT()
        XCTAssertTrue(sut.wikipedia.notEmpty)
    }
    
    func test_init_createsSexagenaryAnimal() throws {
        let sut = try buildSUT()
        XCTAssertNotNil(sut.animals.first?.name)
        XCTAssertNotNil(sut.animals.first?.element)
        XCTAssertNotNil(sut.animals.first?.heavenlyStem)
        XCTAssertNotNil(sut.animals.first?.earthlyBranch)
    }
    
    
    func test_init_firstRecordStartDateBefore1983_isCorrect() throws {
        let sut = try buildSUT()
        
        let expectedDate = chineseDate(from: "1924-02-05")
        
        XCTAssertEqual(sut.animals.first?.dates[0].start, expectedDate)
    }
    
    func test_init_firstRecordEndDateBefore1983_isCorrect() throws {
        let sut = try buildSUT()
                
        let expectedDate = chineseDate(from: "1925-01-23")
        
        XCTAssertEqual(sut.animals.first?.dates[0].end, expectedDate)
    }
    
    func test_init_firstRecordStartDateAfter1984_isCorrect() throws {
        let sut = try buildSUT()
        
        let expectedDate = chineseDate(from: "1984-02-02")
        
        XCTAssertEqual(sut.animals.first?.dates[1].start, expectedDate)
    }
    
    func test_init_firstRecordEndDateAfter1984_isCorrect() throws {
        let sut = try buildSUT()
        
        let expectedDate = chineseDate(from: "1985-02-19")
        
        XCTAssertEqual(sut.animals.first?.dates[1].end, expectedDate)
    }
    
    func test_badDate_throwsError() {
        let lines: [WikipediaLine] = JSONFileReader().decode(string: jsonWithInvalidDate())
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
    
    func test_emptyJSON_throwsError_initWithEmptyLines() {
        let lines: [WikipediaLine] = JSONFileReader().decode(string: jsonSampleEmpty())
        var thrownError: Error?
        
        XCTAssertThrowsError(try Transmogrifier(lines)) {
            thrownError = $0
        }
        
        guard let localError = thrownError as? Transmogrifier.TransmogrifierError else {
            XCTFail("Unexpected error type: \(type(of: thrownError))")
            return
        }
        
        guard case .initWithEmptyLines = localError else {
            XCTFail("Expected \"initWithEmptyLines\" error, but was \(localError) instead.")
            return
        }
        
        XCTAssertTrue(true)
    }
    
    func test_json_containsJSON() throws {
        let sut = try buildSUT()
        let jsonData = sut.json()
        try assertJSONisValid(data: jsonData)
    }
    
    func test_json_contains60Elements() throws {
        let sut = try buildSUT()
        let jsonData = sut.json()
        let animals: [MockAnimal] = decode(data: jsonData)
        XCTAssertEqual(animals.count, 60)
    }
    
    func test_jsonString_isNotEmpty() throws {
        let sut = try buildSUT()
        let jsonString = sut.jsonString()
        XCTAssertTrue(jsonString.notEmpty)
    }
    
    func test_jsonString_hasISO8601Dates() throws {
        let sut = try buildSUT()
        let jsonString = sut.jsonString()
        XCTAssertTrue(jsonString.contains("1949-01-29"))
    }
    
    func test_jsonString_hasNewlines() throws {
        let sut = try buildSUT()
        let jsonString = sut.jsonString()
        XCTAssertTrue(jsonString.contains(where: \.isNewline))
    }
    
    // MARK: - Helpers
    
    fileprivate func buildSUT() throws -> Transmogrifier {
        let records: [WikipediaLine] = JSONFileReader().load()
        return try Transmogrifier(records)
    }
    
    fileprivate func chineseDate(from str: String) -> Date {
        let formatter = DateFormatter.inUTCTimeZone()
        guard let date = formatter.date(from: str) else { fatalError() }
        return date
    }
    
    fileprivate func assertJSONisValid(data: Data, file: StaticString = #filePath, line: UInt = #line) throws {
        XCTAssertNoThrow(try JSONSerialization.jsonObject(with: data), file: file,
                         line: line)
    }
    
    fileprivate func decode<T: Decodable>(data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse data as \(T.self):\n\(error)")
        }
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
    
    fileprivate func jsonWithInvalidDate() -> String {
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

fileprivate struct MockAnimal: Decodable {
    var name: String
    var element: String
    var heavenlyStem: String
    var earthlyBranch: String
    var dates: [DateRange]
    
    struct DateRange: Decodable {
        var start: String
        var end: String
    }
}
