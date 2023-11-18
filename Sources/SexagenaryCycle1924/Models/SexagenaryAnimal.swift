//
//  SexagenaryAnimal.swift
//  SexagenaryCycle1924
//
//  Created by Theo Vora on 11/17/23.
//

import Foundation

public struct SexagenaryAnimal {
    public var animal: String
    public var element: String
    public var heavenlyStem: String
    public var earthlyBranch: String
    public var startDateBefore1983: Date
    public var endDateBefore1983: Date
    public var startDateAfter1984: Date
    public var endDateAfter1984: Date
    public var dates: [DateRange]
    
    public struct DateRange {
        var start: Date
        var end: Date
    }
}
