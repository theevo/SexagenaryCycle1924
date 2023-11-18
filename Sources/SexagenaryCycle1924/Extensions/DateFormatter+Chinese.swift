//
//  DateFormatter+Chinese.swift
//
//
//  Created by Theo Vora on 11/17/23.
//

import Foundation

extension DateFormatter {
    public static func chineseDateFormatter(dateFormat: String = "yyyy-MM-dd") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "HKT")!
        formatter.dateFormat = dateFormat
        
        return formatter
    }
}
