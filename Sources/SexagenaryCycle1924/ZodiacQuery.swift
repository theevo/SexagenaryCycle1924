//
//  ZodiacQuery.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import Foundation

public struct ZodiacQuery {
    let date: Date
    let secondsFromGMT: Int = TimeZone.current.secondsFromGMT()
    let records: ZodiacRecords
    public var animal: SexagenaryAnimal
    
    public init(birthday: String) throws {
        let formatter = DateFormatter.inUTCTimeZone(dateFormat: "MM-dd-yyyy")
        guard let swiftDate = formatter.date(from: birthday) else {
            throw ZodiacRecords.Error.invalidBirthdayInputString(date: birthday)
        }
        self.date = swiftDate
        self.records = try ZodiacRecords()
        self.animal = try records.animalWith(birthday: birthday)
    }
    
    public init(date: Date, secondsFromGMT: Int = TimeZone.current.secondsFromGMT()) throws {
        let birthday = date.timeKiller(secondsFromGMT: secondsFromGMT)
        try self.init(birthday: birthday)
    }
}

extension ZodiacQuery {
    public var range: SexagenaryAnimal.DateRange? {
        animal.range(date: date)
    }
    
    public var prettyPrintRange: String {
        "\(range?.start.shortie(secondsFromGMT: secondsFromGMT) ?? "?") - \(range?.end.shortie(secondsFromGMT: secondsFromGMT) ?? "?")"
    }
}

extension Date {
    func shortie(secondsFromGMT: Int) -> String {
        // shift date to user's local time zone
        let newString = self.timeKiller(secondsFromGMT: 0)
        let formatter0 = DateFormatter()
        formatter0.dateFormat = "MM-dd-yyyy"
        formatter0.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        guard let newDate = formatter0.date(from: newString) else {
            return ""
        }
        
        // present the date in medium style (ex: Feb 9, 2024)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        return formatter.string(from: newDate)
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
