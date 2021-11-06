//
//  API.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/5/21.
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

protocol Query where V: Codable  {
    associatedtype V
    var raw: String { get }
    var variables: V? { get set }
    
}

protocol Variable: Codable {}

struct UserVariable: Variable {
    var email: String
}

struct UserQuery<T: Variable>: Query {
    
    typealias V = T
    
    var raw: String  = """
        query UserQuery($email: String!) {
            user(email: $email)
        }
    """
    var variables: T?
}

struct Payload<T: Codable>: Codable {
    var variables: T?
    var query: String
}
