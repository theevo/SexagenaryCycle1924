//
//  ZodiacQueryTests.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import XCTest
import SexagenaryCycle1924

final class ZodiacQueryTests: XCTestCase {

    func test_whenBirthday11_26_1978_animalIsHorse() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "11-26-1978")
        XCTAssertEqual(animal.name, "Horse")
    }
    
    func test_whenBirthday06_01_1980_animalIsMonkey() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "06-01-1980")
        XCTAssertEqual(animal.name, "Monkey")
    }
    
    func test_whenBirthday03_01_2017_animalIsRooster() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "03-01-2017")
        XCTAssertEqual(animal.name, "Rooster")
    }
    
    func test_whenBirthday09_01_1985_animalIsRat() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "09-01-1985")
        XCTAssertEqual(animal.name, "Ox")
    }
    
    func test_whenBirthday02_11_1975_animalIsRabbit_elementIsYinWood() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "02-11-1975")
        XCTAssertEqual(animal.name, "Rabbit")
        XCTAssertEqual(animal.element, "Yin Wood")
    }
    
    func test_whenBirthday02_10_1975_animalIsRabbit_elementIsYangWood() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "02-10-1975")
        XCTAssertEqual(animal.name, "Tiger")
        XCTAssertEqual(animal.element, "Yang Wood")
    }
}
