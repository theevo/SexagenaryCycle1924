//
//  JSONFileReader.swift
//
//
//  Created by Theo Vora on 10/22/23.
//

import Foundation

public class JSONFileReader {
    public init() { }
    
    public func load<T: Decodable>(_ filename: String = "Wikipedia-Sexagenary-cycle.json") -> T {
        let data: Data
        let bundle = Bundle.module

        guard let file = bundle.url(forResource: filename, withExtension: nil)
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
