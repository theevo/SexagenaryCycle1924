//
//  ZodiacQuery.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import Foundation

public struct ZodiacQuery {
    public var animal: SexagenaryAnimal
    
    let records: ZodiacRecords
    
    public init(birthday: String) throws {
        self.records = try ZodiacRecords()
        self.animal = try records.animalWith(birthday: birthday)
    }
    
    public init(date: Date) throws {
        self.records = try ZodiacRecords()
        self.animal = SexagenaryAnimal(name: .Dragon, element: "", heavenlyStem: "", earthlyBranch: "", dates: [])
    }
}
