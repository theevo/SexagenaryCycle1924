//
//  ZodiacQuery.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import Foundation

public struct ZodiacQuery {
    public var animal: SexagenaryAnimal?
    
    let animals: [SexagenaryAnimal]
    
    public init(birthday: String) throws {
        let records: [WikipediaLine] = JSONFileReader().load()
        self.animals = try Transmogrifier(records).animals
        
        self.animal = try animalWith(birthday: birthday)
    }
    
    fileprivate func animalWith(birthday: String) throws -> SexagenaryAnimal {
        let formatter = DateFormatter.inUTCTimeZone(dateFormat: "MM-dd-yyyy")
        guard let swiftDate = formatter.date(from: birthday) else {
            throw Error.invalidBirthdayInputString(date: birthday)
        }
        
        guard let animal = contains(date: swiftDate) else {
            throw Error.noAnimalFoundWithThatBirthday(date: birthday)
        }
        
        return animal
    }
    
    fileprivate func contains(date: Date) -> SexagenaryAnimal? {
        return animals.first { animal in
            animal.contains(date: date)
        }
    }
}

extension ZodiacQuery {
    enum Error: LocalizedError {
        case invalidBirthdayInputString(date: String)
        case noAnimalFoundWithThatBirthday(date: String)
        
        var description: String {
            switch self {
            case .invalidBirthdayInputString(let date):
                return "Invalid birthdate: \(date). Format must be MM-DD-YYYY."
            case .noAnimalFoundWithThatBirthday(let date):
                return "Could not find animal matching this date: \(date). This API only covers the years 1924 - 2044."
            }
        }
    }
}
