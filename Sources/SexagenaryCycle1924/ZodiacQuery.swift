//
//  ZodiacQuery.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import Foundation

public struct ZodiacQuery {
    let animals: [SexagenaryAnimal]
    
    public init() {
        let records: [WikipediaLine] = JSONFileReader().load()
        self.animals = try! Transmogrifier(records).animals
    }
    
    public func birthday(date: String) -> SexagenaryAnimal {
        let formatter = DateFormatter.chineseDateFormatter(dateFormat: "MM-dd-yyyy")
        guard let date = formatter.date(from: date) else {
            fatalError()
        }
        
        guard let animal = contains(date: date) else {
            fatalError()
        }
        
        return animal
    }
    
    fileprivate func contains(date: Date) -> SexagenaryAnimal? {
        return animals.first { animal in
            animal.contains(date: date)
        }
    }
}