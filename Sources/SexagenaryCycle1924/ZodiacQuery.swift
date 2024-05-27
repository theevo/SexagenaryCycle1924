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
    
    public init(date: Date, secondsFromGMT: Int = TimeZone.current.secondsFromGMT()) throws {
        let birthday = ZodiacQuery.timeKiller(date: date, secondsFromGMT: secondsFromGMT)
        try self.init(birthday: birthday)
    }
    
    static func timeKiller(date: Date, secondsFromGMT: Int) -> String {
        let usersIntendedDateFormatter = DateFormatter()
        usersIntendedDateFormatter.dateFormat = "MM-dd-yyyy"
        usersIntendedDateFormatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        let string = usersIntendedDateFormatter.string(from: date)
        print(string)
        
        return string
    }
}
