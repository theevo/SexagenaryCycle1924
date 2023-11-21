//
//  ZodiacQueryTests.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import XCTest
import SexagenaryCycle1924

final class ZodiacQueryTests: XCTestCase {

    func test_whenBirthday11261978_animalIsHorse() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "11-26-1978")
        XCTAssertEqual(animal.name, "Horse")
    }
    
    func test_whenBirthday06011980_animalIsMonkey() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "06-01-1980")
        XCTAssertEqual(animal.name, "Monkey")
    }
    
    func test_whenBirthday03012017_animalIsRooster() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "03-01-2017")
        XCTAssertEqual(animal.name, "Rooster")
    }
    
    func test_whenBirthday09011985_animalIsRat() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "09-01-1985")
        XCTAssertEqual(animal.name, "Ox")
    }
}
