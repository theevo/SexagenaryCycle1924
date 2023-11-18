//
//  ZodiacQueryTests.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import XCTest
import SexagenaryCycle1924

final class ZodiacQueryTests: XCTestCase {

    func test_giveBirthday_getAnimal() {
        let query = ZodiacQuery()
        let animal = query.birthday(date: "11-26-1978")
        XCTAssertEqual(animal.animal, "Horse")
    }

}
