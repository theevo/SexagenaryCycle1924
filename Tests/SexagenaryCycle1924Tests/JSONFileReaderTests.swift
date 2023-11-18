import XCTest
import SexagenaryCycle1924

final class JSONFileReaderTests: XCTestCase {
    func test_load_givesModelRecords() {
        let sut = JSONFileReader()
        let records: [WikipediaLine] = sut.load()
        XCTAssertTrue(records.notEmpty)
    }
    
    func test_load_yieldsRecordWithAnAnimal() {
        let sut = JSONFileReader()
        let records: [WikipediaLine] = sut.load()
        XCTAssertTrue(records.first?.animal.notEmpty ?? false)
    }
    
    func test_decode_yieldsRecordWithAnAnimal() {
        let sut = JSONFileReader()
        
        let jsonStr = jsonSample()

        
        let records: [WikipediaLine] = sut.decode(string: jsonStr)
        XCTAssertEqual(records[0].animal, "Horse")
        XCTAssertEqual(records[1].animal, "Monkey")
        XCTAssertEqual(records[2].animal, "Ox")
    }
    
    // MARK: - Helpers
    
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
}
