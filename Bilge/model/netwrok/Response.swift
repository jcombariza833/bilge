//
//  Response.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/6/21.
//

import Foundation

enum RequestErrors: Error {
    case networkError(String)
}

struct APIError: Codable {
    var message: String
    var locations: [Location]
    
}

struct Location: Codable {
    var line: Int
    var column: Int
}

struct Response<T: Codable>: Codable {
    var data: T?
    var errors: [APIError]?
}
