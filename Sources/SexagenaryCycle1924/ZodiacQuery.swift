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
    
    /// Pretty print the exact date range that matched that date you fed to `init()`
    /// - Parameter dateStyle: default value: `.medium`
    /// - Returns: example: "Jan 22, 2023 - Feb 9, 2024"
    public func prettyPrintRange(dateStyle: DateFormatter.Style = .medium) -> String {
        "\(dateString(date: range?.start, dateStyle: dateStyle)) - \(dateString(date: range?.end, dateStyle: dateStyle))"
    }
    
    func dateString(date: Date?, dateStyle: DateFormatter.Style = .medium) -> String {
        "\(date?.printInTimeZone(secondsFromGMT: secondsFromGMT, dateStyle: dateStyle) ?? "?")"
    }
}

extension Date {
    func printInTimeZone(secondsFromGMT: Int, dateStyle: DateFormatter.Style = .medium) -> String {
        guard let newDate = self.shiftDateToTimeZone(secondsFromGMT: secondsFromGMT) else {
            return ""
        }
        
        // present the date in medium style (ex: Feb 9, 2024)
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        return formatter.string(from: newDate)
    }
    
    public func shiftDateToTimeZone(secondsFromGMT: Int) -> Date? {
        let newString = self.timeKiller(secondsFromGMT: 0)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        return formatter.date(from: newString)
    }
    
    public func timeKiller(secondsFromGMT: Int) -> String {
        let usersIntendedDateFormatter = DateFormatter()
        usersIntendedDateFormatter.dateFormat = "MM-dd-yyyy"
        usersIntendedDateFormatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        return usersIntendedDateFormatter.string(from: self)
    }
}
