//
//  DateFormatter+UTCTimeZone.swift
//
//
//  Created by Theo Vora on 11/17/23.
//

import Foundation

extension DateFormatter {
    // TODO: - can this be computed property?
    public static func inUTCTimeZone(dateFormat: String = "yyyy-MM-dd") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")!
        formatter.dateFormat = dateFormat
        
        return formatter
    }
}
