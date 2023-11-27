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
    
    func test_whenAnimalIsHorse_compatibilitiesContain_Dog_Goat_Tiger() throws {
        let query = try ZodiacQuery(birthday: "11-26-1978")
        XCTAssertTrue(query.compatibilities.contains("Dog"))
        XCTAssertTrue(query.compatibilities.contains("Goat"))
        XCTAssertTrue(query.compatibilities.contains("Tiger"))
    }
    
    func test_whenAnimalIsGoat_compatibilitiesContain_Goat_Rabbit_Horse_Pig() throws {
        let query = try ZodiacQuery(birthday: "03-01-1979")
        XCTAssertTrue(query.compatibilities.contains("Goat"))
        XCTAssertTrue(query.compatibilities.contains("Rabbit"))
        XCTAssertTrue(query.compatibilities.contains("Horse"))
        XCTAssertTrue(query.compatibilities.contains("Pig"))
    }
}
