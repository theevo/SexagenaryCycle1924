//
//  ZodiacQueryTests.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import XCTest
@testable import SexagenaryCycle1924

final class ZodiacQueryTests: XCTestCase {

    func test_whenBirthday11_26_1978_animalIsHorse() throws {
        let query = try ZodiacQuery(birthday: "11-26-1978")
        let animal = query.animal
        XCTAssertEqual(animal.name, .Horse)
    }
    
    func test_whenBirthday06_01_1980_animalIsMonkey() throws {
        let query = try ZodiacQuery(birthday: "06-01-1980")
        let animal = query.animal
        XCTAssertEqual(animal.name, .Monkey)
    }
    
    func test_whenBirthday03_01_2017_animalIsRooster() throws {
        let query = try ZodiacQuery(birthday: "03-01-2017")
        let animal = query.animal
        XCTAssertEqual(animal.name, .Rooster)
    }
    
    func test_whenBirthday09_01_1985_animalIsRat() throws {
        let query = try ZodiacQuery(birthday: "09-01-1985")
        let animal = query.animal
        XCTAssertEqual(animal.name, .Ox)
    }
    
    func test_whenBirthday02_11_1975_animalIsRabbit_elementIsYinWood() throws {
        let query = try ZodiacQuery(birthday: "02-11-1975")
        let animal = query.animal
        XCTAssertEqual(animal.name, .Rabbit)
        XCTAssertEqual(animal.element, "Yin Wood")
    }
    
    func test_whenBirthday02_10_1975_animalIsRabbit_elementIsYangWood() throws {
        let query = try ZodiacQuery(birthday: "02-10-1975")
        let animal = query.animal
        XCTAssertEqual(animal.name, .Tiger)
        XCTAssertEqual(animal.element, "Yang Wood")
    }
    
    func test_whenBirthday01_01_1900_returnsError() throws {
        var thrownError: Error?
        
        XCTAssertThrowsError(try ZodiacQuery(birthday: "01-01-1900")) {
            thrownError = $0
        }
        
        guard let localError = thrownError as? ZodiacRecords.Error else {
            XCTFail("Unexpected error type: \(type(of: thrownError))")
            return
        }
        
        guard case .noAnimalFoundWithThatBirthday(_) = localError else {
            XCTFail("Expected \"noAnimalFoundWithThatBirthday\" error, but was \(localError) instead.")
            return
        }
        
        XCTAssertTrue(true)
    }
    
    func test_whenBirthday01_01_2100_returnsError() throws {
        var thrownError: Error?
        
        XCTAssertThrowsError(try ZodiacQuery(birthday: "01-01-2100")) {
            thrownError = $0
        }
        
        guard let localError = thrownError as? ZodiacRecords.Error else {
            XCTFail("Unexpected error type: \(type(of: thrownError))")
            return
        }
        
        guard case .noAnimalFoundWithThatBirthday(_) = localError else {
            XCTFail("Expected \"noAnimalFoundWithThatBirthday\" error, but was \(localError) instead.")
            return
        }
        
        XCTAssertTrue(true)
    }
    
    func test_whenBirthdayIsGarbage_returnsError() throws {
        var thrownError: Error?
        
        XCTAssertThrowsError(try ZodiacQuery(birthday: "2782819")) {
            thrownError = $0
        }
        
        guard let localError = thrownError as? ZodiacRecords.Error else {
            XCTFail("Unexpected error type: \(type(of: thrownError))")
            return
        }
        
        guard case .invalidBirthdayInputString(_) = localError else {
            XCTFail("Expected \"invalidBirthdayInputString\" error, but was \(localError) instead.")
            return
        }
        
        XCTAssertTrue(true)
    }
    
    // MARK: - Using Swift Date
    
    func test_whenSwiftDateIs_2024_05_25_AnimalIsDragon() throws {
        let date = makeDate(month: "05", day: "25", year: "2024")
        let query = try ZodiacQuery(date: date)
        let animal = query.animal
        XCTAssertEqual(animal.name, .Dragon)
    }
    
    func test_whenSwiftDateIs_2023_05_25_AnimalIsRabbit() throws {
        let date = makeDate(month: "05", day: "25", year: "2023")
        let query = try ZodiacQuery(date: date)
        let animal = query.animal
        XCTAssertEqual(animal.name, .Rabbit)
    }
    
    func test_whenSwiftDateIs_3000_05_25_ThrowsError() throws {
        let date = makeDate(month: "05", day: "25", year: "3000")
        
        var thrownError: Error?
        
        XCTAssertThrowsError(try ZodiacQuery(date: date)) {
            thrownError = $0
        }
        
        guard let localError = thrownError as? ZodiacRecords.Error else {
            XCTFail("Unexpected error type: \(type(of: thrownError))")
            return
        }
        
        guard case .noAnimalFoundWithThatBirthday(_) = localError else {
            XCTFail("Expected \"noAnimalFoundWithThatBirthday\" error, but was \(localError) instead.")
            return
        }
        
        XCTAssertTrue(true)
    }
    
    func testTimeKiller_2023_05_25_22_00_CDT_returns_05_25_2023() {
        let date = makeDate(month: "05", day: "25", year: "2023")
        
        let string = date.timeKiller(secondsFromGMT: -18000)
        
        XCTAssertEqual(string, "05-25-2023")
    }
    
    func testTimeKiller_2024_02_09_11_53_CDT_returns_02_09_2024() {
        let date = makeDate(month: "02", day: "09", year: "2024", time: "11:53", secondsFromGMT: -18000)
        
        let string = date.timeKiller(secondsFromGMT: -18000)
        
        XCTAssertEqual(string, "02-09-2024")
    }
    
    func test_whenSwiftDateIs_2024_02_09_AnimalIsRabbit() throws {
        let date = makeDate(month: "02", day: "09", year: "2024")
        let query = try ZodiacQuery(date: date, secondsFromGMT: -18000)
        let animal = query.animal
        XCTAssertEqual(animal.name, .Rabbit)
    }
    
    // MARK: - Helpers
    
    /// constructor for `Date` that simulates what could come out of a `DatePicker` in the worst possible way: the date the user intended vs the date according to GMT. _warning_: there is no type safety in the parameters, so please don't enter garbage.
    /// - Parameters:
    ///   - month: 2-digit month. "01" would be January
    ///   - day: 2-digit day
    ///   - year: 4-digit year
    ///   - time: 4-digit time in military time with colon delimiter between HH:mm. Ex: "01:00" would be 1:00 am and "13:00" would be 1:00 pm. default: "22:00" which is 10pm Central but 3am GMT the next day.
    ///   - secondsFromGMT: default: -18000 which is US Central Daylight Savings Time Zone
    /// - Returns: Swift `Date` with your parameters
    func makeDate(month: String, day: String, year: String, time: String = "22:00", secondsFromGMT: Int = -18000) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        let someDateTime = formatter.date(from: "\(year)/\(month)/\(day) \(time)")
        
        guard let date = someDateTime else {
            fatalError("Expected this string to generate a valid date, but it failed: \(year)/\(month)/\(day)")
        }
        return date
    }
}
