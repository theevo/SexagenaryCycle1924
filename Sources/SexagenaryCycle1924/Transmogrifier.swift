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
            let dates = line.yearBefore1983.split(separator: "–")
            
            let dateStr1 = String(dates[0])
            let dateStr2 = String(dates[1])
            
            let formatter = chineseDateFormatter(dateFormat: "MMM dd yyyy")
            
            guard let date1 = formatter.date(from: dateStr1),
                  let date2 = formatter.date(from: dateStr2)
            else { fatalError() }
            
            return SexagenaryAnimal(
                animal: line.animal,
                element: line.element,
                heavenlyStem: line.heavenlyStem,
                earthlyBranch: line.earthlyBranch,
                startDateBefore1983: date1,
                endDateBefore1983: date2
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
