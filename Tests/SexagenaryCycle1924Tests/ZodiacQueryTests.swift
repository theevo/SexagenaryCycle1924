//
//  ZodiacQueryTests.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import XCTest
import SexagenaryCycle1924

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
    
    // MARK: - Helpers
    
    func makeDate(month: String, day: String, year: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "\(year)/\(month)/\(day) 12:00")
        
        guard let date = someDateTime else {
            fatalError("Expected this string to generate a valid date, but it failed: \(year)/\(month)/\(day)")
        }
        return date
    }
}
