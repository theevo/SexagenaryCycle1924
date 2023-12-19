//
//  JSONFilePublisher.swift
//
//
//  Created by Theo Vora on 12/19/23.
//

import Foundation
import SexagenaryCycle1924

public struct JSONFilePublisher {
    public var lines: [WikipediaLine]
    
    public init() {
        let lines: [WikipediaLine] = JSONFileReader().load()
        self.lines = lines
    }
}
