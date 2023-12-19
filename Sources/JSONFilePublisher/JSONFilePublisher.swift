//
//  JSONFilePublisher.swift
//
//
//  Created by Theo Vora on 12/19/23.
//

import Foundation
import SexagenaryCycle1924

public struct JSONFilePublisher {
    public var json: String
    
    public init() throws {
        let lines: [WikipediaLine] = JSONFileReader().load()
        let transmogrifier = try Transmogrifier(lines)
        self.json = transmogrifier.jsonString()
    }
}
