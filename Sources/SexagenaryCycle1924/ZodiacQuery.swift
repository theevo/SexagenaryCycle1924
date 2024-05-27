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
        let birthday = date.timeKiller(secondsFromGMT: secondsFromGMT)
        try self.init(birthday: birthday)
    }
}

extension Date {
    public func timeKiller(secondsFromGMT: Int) -> String {
        let usersIntendedDateFormatter = DateFormatter()
        usersIntendedDateFormatter.dateFormat = "MM-dd-yyyy"
        usersIntendedDateFormatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        return usersIntendedDateFormatter.string(from: self)
    }
}
