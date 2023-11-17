//
//  JSONFileReader.swift
//
//
//  Created by Theo Vora on 10/22/23.
//

import Foundation

public struct SexagenaryAnimal {
    public var animal: String
    public var element: String
    public var heavenlyStem: String
    public var earthlyBranch: String
    public var startDateBefore1983: Date
}

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
            let dateStr1 = String(line.yearBefore1983.split(separator: "–").first!)
            
            let formatter = chineseDateFormatter(dateFormat: "MMM dd yyyy")
            
            guard let date1 = formatter.date(from: dateStr1) else { fatalError() }
            
            return SexagenaryAnimal(
                animal: line.animal,
                element: line.element,
                heavenlyStem: line.heavenlyStem,
                earthlyBranch: line.earthlyBranch, 
                startDateBefore1983: date1
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

public class JSONFileReader {
    public init() { }
    
    public func load<T: Decodable>(_ filename: String = "Wikipedia-Sexagenary-cycle.json") -> T {
        let data: Data
        let bundle = Bundle.module

        guard let file = bundle.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
