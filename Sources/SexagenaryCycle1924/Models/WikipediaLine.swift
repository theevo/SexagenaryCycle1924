//
//  WikipediaLine.swift
//
//
//  Created by Theo Vora on 11/16/23.
//

import Foundation

public struct WikipediaLine: Decodable {
    public var line: String
    public var yearBefore1983: String
    public var yearAfter1984: String
    public var element: String
    public var heavenlyStem: String
    public var earthlyBranch: String
    public var animal: String
    
    enum CodingKeys: String, CodingKey {
        case line = "Line"
        case yearBefore1983 = "Year 1924–1983"
        case yearAfter1984 = "Year 1984–2043"
        case element = "Associated element"
        case heavenlyStem = "Heavenly stem"
        case earthlyBranch = "Earthly branch"
        case animal = "Associated animal"
    }
}
