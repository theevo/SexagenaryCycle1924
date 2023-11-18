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
            
            let (date1, date2) = datesBefore1983(line)
            let (date3, date4) = datesAfter1984(line)
            
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
    fileprivate func datesBefore1983(_ line: WikipediaLine) -> (Date, Date) {
        datesFrom(dashSeparated: line.yearBefore1983)
    }
    
    fileprivate func datesAfter1984(_ line: WikipediaLine) -> (Date, Date) {
        datesFrom(dashSeparated: line.yearAfter1984)
    }
    
    fileprivate func datesFrom(dashSeparated str: String) -> (Date, Date) {
        let dates = str.split(separator: "–")
        
        let dateStr1 = String(dates[0])
        let dateStr2 = String(dates[1])
        
        let formatter = DateFormatter.chineseDateFormatter(dateFormat: "MMM dd yyyy")
        
        guard let date1 = formatter.date(from: dateStr1),
              let date2 = formatter.date(from: dateStr2)
        else { fatalError() }
        
        return (date1, date2)
    }
}
