//
//  ZodiacRecords.swift
//  SexagenaryCycle1924
//
//  Created by Theo Vora on 11/27/23.
//

import Foundation

internal struct ZodiacRecords {
    let animals: [SexagenaryAnimal]
    
    init() throws {
        let records: [WikipediaLine] = JSONFileReader().load()
        self.animals = try Transmogrifier(records).animals
    }
    
    func animalWith(birthday: String) throws -> SexagenaryAnimal {
        let formatter = DateFormatter.inUTCTimeZone(dateFormat: "MM-dd-yyyy")
        guard let swiftDate = formatter.date(from: birthday) else {
            throw Error.invalidBirthdayInputString(date: birthday)
        }
        
        guard let animal = contains(date: swiftDate) else {
            throw Error.noAnimalFoundWithThatBirthday(date: birthday)
        }
        
        return animal
    }
    
    func compatibleSignsWith(animal: SexagenaryAnimal) -> [SexagenaryAnimal.Name] {
        switch animal.name {
            
            // correct
        case .Rat:
            return [.Rat, .Ox, .Dragon, .Monkey]
        case .Ox:
            return [.Rat, .Rooster, .Snake]
        case .Tiger:
            return [.Dog, .Horse, .Pig]
            
            // NOT CORRECT
        case .Rabbit:
            return [.Dog, .Goat, .Tiger]
        case .Dragon:
            return [.Goat, .Rabbit, .Horse, .Pig]
        case .Snake:
            return [.Dog, .Goat, .Tiger]
        case .Goat:
            return [.Goat, .Rabbit, .Horse, .Pig]
            
            // correct
        case .Horse:
            return [.Dog, .Goat, .Tiger]
        case .Monkey:
            return [.Goat, .Rabbit, .Horse, .Pig]
            
            // NOT CORRECT
        case .Rooster:
            return [.Dog, .Goat, .Tiger]
        case .Dog:
            return [.Goat, .Rabbit, .Horse, .Pig]
        case .Pig:
            return [.Dog, .Goat, .Tiger]
        }
    }
    
    fileprivate func contains(date: Date) -> SexagenaryAnimal? {
        return animals.first { animal in
            animal.contains(date: date)
        }
    }
}

extension ZodiacRecords {
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
