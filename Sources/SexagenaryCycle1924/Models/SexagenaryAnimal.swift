//
//  SexagenaryAnimal.swift
//  SexagenaryCycle1924
//
//  Created by Theo Vora on 11/17/23.
//

import Foundation

public struct SexagenaryAnimal: Encodable {
    public var name: Name
    public var element: String
    public var heavenlyStem: String
    public var earthlyBranch: String
    public var dates: [DateRange]
    
    public struct DateRange: Encodable {
        public var start: Date
        public var end: Date
    }
}

extension SexagenaryAnimal {
    public enum Name: String, Encodable {
        case Rat
        case Ox
        case Tiger
        case Rabbit
        case Dragon
        case Snake
        case Horse
        case Goat
        case Monkey
        case Rooster
        case Dog
        case Pig
    }
}

extension SexagenaryAnimal {
    public func contains(date: Date) -> Bool {
        dates.contains { range in
            range.contains(date: date)
        }
    }
    
    public func range(date: Date) -> SexagenaryAnimal.DateRange? {
        dates.first { range in
            range.contains(date: date)
        }
    }
}

extension SexagenaryAnimal.DateRange {
    public func contains(date: Date) -> Bool {
        let range = start...end
        return range.contains(date)
    }
}



extension SexagenaryAnimal.DateRange: CustomStringConvertible {
    public var description: String {
        "SexagenaryAnimal.DateRange: \(start.description) - \(end.description)"
    }
}
