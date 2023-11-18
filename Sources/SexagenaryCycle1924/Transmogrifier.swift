//
//  Transmogrifier.swift
//
//
//  Created by Theo Vora on 11/17/23.
//

import Foundation

public struct Transmogrifier {
    public var wikipedia: [WikipediaLine]?
    public var animals: [SexagenaryAnimal] = []
    
    public init(_ wikipediaLines: [WikipediaLine]) throws {
        self.wikipedia = wikipediaLines
        try mapAnimals()
    }
    
    private mutating func mapAnimals() throws {
        guard let wikipedia = wikipedia else { return }
        animals = try wikipedia.map({ line in
            
            let (date1, date2) = try datesBefore1983(line)
            let (date3, date4) = try datesAfter1984(line)
            
            return SexagenaryAnimal(
                animal: line.animal,
                element: line.element,
                heavenlyStem: line.heavenlyStem,
                earthlyBranch: line.earthlyBranch,
                startDateBefore1983: date1,
                endDateBefore1983: date2,
                startDateAfter1984: date3,
                endDateAfter1984: date4
            )
        })
    }
}

extension Transmogrifier {
    fileprivate func datesBefore1983(_ line: WikipediaLine) throws -> (Date, Date) {
        try datesFrom(dashSeparated: line.yearBefore1983)
    }
    
    fileprivate func datesAfter1984(_ line: WikipediaLine) throws -> (Date, Date) {
        try datesFrom(dashSeparated: line.yearAfter1984)
    }
    
    fileprivate func datesFrom(dashSeparated str: String) throws -> (Date, Date) {
        let dates = str.split(separator: "–")
        
        let dateStr1 = String(dates[0])
        let dateStr2 = String(dates[1])
        
        let date1 = try dateInChinaTimeZoneFrom(string: dateStr1)
        let date2 = try dateInChinaTimeZoneFrom(string: dateStr2)
        return (date1, date2)
    }
    
    fileprivate func dateInChinaTimeZoneFrom(string: String) throws -> Date {
        let formatter = DateFormatter.chineseDateFormatter(dateFormat: "MMM dd yyyy")
        guard let date = formatter.date(from: string) else {
            throw TransmogrifierError.failedToParseDate(string)
        }
        return date
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
