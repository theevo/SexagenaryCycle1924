//
//  JSONFilePublisher.swift
//
//
//  Created by Theo Vora on 12/19/23.
//

import ArgumentParser
import SexagenaryCycle1924

@main
struct JSONPrinter: ParsableCommand {
    mutating func run() throws {
        let publisher = try TransmogrifierBuilder()
        print(publisher.json)
    }
}

public struct TransmogrifierBuilder {
    public var json: String
    
    public init() throws {
        let lines: [WikipediaLine] = JSONFileReader().load()
        let transmogrifier = try Transmogrifier(lines)
        self.json = transmogrifier.jsonString()
    }
}
