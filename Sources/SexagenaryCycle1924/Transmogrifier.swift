//
//  Transmogrifier.swift
//
//
//  Created by Theo Vora on 11/17/23.
//

import Foundation

public struct Transmogrifier {
    public var wikipedia: [WikipediaLine]
    public var animals: [SexagenaryAnimal] = []
    
    public init(_ wikipediaLines: [WikipediaLine]) throws {
        self.wikipedia = wikipediaLines
        try mapAnimals()
    }
    
    private mutating func mapAnimals() throws {
        animals = try wikipedia.map({ line in
            
            let ranges = try buildDateRangesFrom(wikiLine: line)
            
            return SexagenaryAnimal(
                name: line.animal,
                element: line.element,
                heavenlyStem: line.heavenlyStem,
                earthlyBranch: line.earthlyBranch,
                dates: ranges
            )
        })
    }
}

extension Transmogrifier {
    fileprivate func datesFrom(dashSeparated str: String) throws -> (Date, Date) {
        let dates = str.split(separator: "–")
        
        let dateStr1 = String(dates[0])
        let dateStr2 = String(dates[1])
        
        let date1 = try dateInUTCTimeZoneFrom(string: dateStr1)
        let date2 = try dateInUTCTimeZoneFrom(string: dateStr2)
        return (date1, date2)
    }
    
    fileprivate func dateInUTCTimeZoneFrom(string: String) throws -> Date {
        let formatter = DateFormatter.inUTCTimeZone(dateFormat: "MMM dd yyyy")
        guard let date = formatter.date(from: string) else {
            throw TransmogrifierError.failedToParseDate(string)
        }
        return date
    }
    
    fileprivate func buildDateRangesFrom(wikiLine line: WikipediaLine) throws -> [SexagenaryAnimal.DateRange] {
        let range1 = try buildDateRangeFrom(dashSeparated: line.yearBefore1983)
        let range2 = try buildDateRangeFrom(dashSeparated: line.yearAfter1984)
        
        return [range1, range2]
    }
    
    fileprivate func buildDateRangeFrom(dashSeparated: String) throws -> SexagenaryAnimal.DateRange {
        let (date1, date2) = try datesFrom(dashSeparated: dashSeparated)
        return SexagenaryAnimal.DateRange(start: date1, end: date2)
    }
}

extension Transmogrifier {
    public enum TransmogrifierError: LocalizedError, Equatable {
        case failedToParseDate(String)
        
        public var errorDescription: String? {
            switch self {
            case .failedToParseDate(let str):
                return "Could not parse date: \(str)"
            }
        }
    }
}
