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
        let animal = SexagenaryAnimal(animal: "Horse", element: "", heavenlyStem: "", earthlyBranch: "", dates: [])
        return animal
    }
}
