import XCTest
@testable import SexagenaryCycle1924

final class SexagenaryCycle1924Tests: XCTestCase {
    func test_jsonFilePath_isNotEmpty() {
        let foo = FileHandler()
        let path = foo.path
        XCTAssertNotNil(path)
    }
    
    func test_jsonFileURL_isNotEmpty() {
        let foo = FileHandler()
        let url = foo.url
        XCTAssertNotNil(url)
    }
    
    func test_jsonFileData_isNotEmpty() {
        let foo = FileHandler()
        print(foo.data)
        XCTAssertNotNil(foo.data)
    }
}
