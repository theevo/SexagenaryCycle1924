import XCTest
import SexagenaryCycle1924

final class SexagenaryCycle1924Tests: XCTestCase {
    func test_load_givesModelRecords() {
        let sut = FileHandler()
        let records: [WikipediaLine] = sut.load()
        XCTAssertFalse(records.isEmpty)
    }
    
    func test_load_yieldsRecordWithAnAnimal() {
        let sut = FileHandler()
        let records: [WikipediaLine] = sut.load()
        XCTAssertFalse(records.first?.animal.isEmpty ?? true)
    }
}

struct WikipediaLine: Decodable {
    var line: String
    var yearBefore1983: String
    var yearAfter1984: String
    var element: String
    var heavenlyStem: String
    var earthlyBranch: String
    var animal: String
    
    enum CodingKeys: String, CodingKey {
        case line = "Line"
        case yearBefore1983 = "Year 1924–1983"
        case yearAfter1984 = "Year 1984–2043"
        case element = "Associated element"
        case heavenlyStem = "Heavenly stem"
        case earthlyBranch = "Earthly branch"
        case animal = "Associated animal"
    }
}
