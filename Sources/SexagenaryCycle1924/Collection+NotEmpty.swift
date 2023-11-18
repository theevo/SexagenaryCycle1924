//
//  Collection+NotEmpty.swift
//
//
//  Created by Theo Vora on 11/18/23.
//

import Foundation

extension Collection {
    public var notEmpty: Bool {
        !self.isEmpty
    }
}
