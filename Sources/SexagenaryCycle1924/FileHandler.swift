//
//  FileHandler.swift
//
//
//  Created by Theo Vora on 10/22/23.
//

import Foundation

class FileHandler {
    var url: URL?
    var path: String?
    
    init() {
        getPath()
    }
    
    fileprivate func getPath() {
        let bundle = Bundle.module
        guard let myURL = bundle.url(forResource: "Wikipedia-Sexagenary-cycle", withExtension: "json") else {
            fatalError("unable to locate Wikipedia-Sexagenary-cycle.json")
        }
        url = myURL
        path = myURL.path
    }
}
