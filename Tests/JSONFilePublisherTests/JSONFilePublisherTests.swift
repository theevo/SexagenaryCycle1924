//
//  JSONFilePublisherTests.swift
//  
//
//  Created by Theo Vora on 12/19/23.
//

import XCTest
import JSONFilePublisher

final class JSONFilePublisherTests: XCTestCase {
    
    func test_init_loadsLines() {
        let sut = JSONFilePublisher()
        XCTAssertTrue(sut.lines.notEmpty)
    }

}
