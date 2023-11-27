//
//  ZodiacQuery.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import Foundation

public struct ZodiacQuery {
    public var animal: SexagenaryAnimal
    public var compatibilities: [SexagenaryAnimal.Name]
    
    let records: ZodiacRecords
    
    public init(birthday: String) throws {
        self.records = try ZodiacRecords()
        self.animal = try records.animalWith(birthday: birthday)
        self.compatibilities = records.compatibleSignsWith(animal: self.animal)
    }
}
