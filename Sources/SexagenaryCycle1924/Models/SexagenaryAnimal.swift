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
    public var dates: [DateRange]
    
    public struct DateRange {
        public var start: Date
        public var end: Date
    }
}
