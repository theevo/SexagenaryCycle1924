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
    
    public init(_ wikipediaLines: [WikipediaLine]) {
        self.wikipedia = wikipediaLines
        mapAnimals()
    }
    
    private mutating func mapAnimals() {
        guard let wikipedia = wikipedia else { return }
        animals = wikipedia.map({ line in
            
            let (date1, date2) = line.datesBefore1983
            let (date3, date4) = line.datesAfter1984
            
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
    
    public func chineseDateFormatter(dateFormat: String = "yyyy-MM-dd") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "HKT")!
        formatter.dateFormat = dateFormat
        
        return formatter
    }
}

extension WikipediaLine {
    fileprivate var datesBefore1983: (Date, Date) {
        datesFrom(dashSeparated: yearBefore1983)
    }
    
    fileprivate var datesAfter1984: (Date, Date) {
        datesFrom(dashSeparated: yearAfter1984)
    }
    
    fileprivate func datesFrom(dashSeparated str: String) -> (Date, Date) {
        let dates = str.split(separator: "–")
        
        let dateStr1 = String(dates[0])
        let dateStr2 = String(dates[1])
        
        let formatter = Transmogrifier([]).chineseDateFormatter(dateFormat: "MMM dd yyyy")
        
        guard let date1 = formatter.date(from: dateStr1),
              let date2 = formatter.date(from: dateStr2)
        else { fatalError() }
        
        return (date1, date2)
    }
}