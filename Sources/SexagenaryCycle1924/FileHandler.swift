//
//  FileHandler.swift
//
//
//  Created by Theo Vora on 10/22/23.
//

import Foundation

public class FileHandler {
    public init() { }
    
    public func load<T: Decodable>(_ filename: String = "Wikipedia-Sexagenary-cycle") -> T {
        let data: Data
        let bundle = Bundle.module

        guard let file = bundle.url(forResource: filename, withExtension: "json")
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
