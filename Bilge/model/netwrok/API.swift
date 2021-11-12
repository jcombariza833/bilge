//
//  API.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/5/21.
//

import Foundation
import Thunder

enum API<T: Variable> {
    case user(Variable)
    
    func payload() -> Payload<T> {
        switch self {
        case .user(let variables):
            return Payload<T>(query: self.query(), variables: variables as? T)
        }
    }
    
    private func query() -> String {
        switch self {
        case .user:
            return """
                query UserQuery($email: String!) {
                    user(email: $email)
                }
            """
        }
    }
    
    static func request(payload: Payload<T>, token: String) -> URLRequest {
        return  RequestBuilder(url: url())
                    .addHttpMethod(.post)
                    .addAllHTTPHeaderFields(["Content-Type": "application/json",
                                             "Accept": "application/json",
                                             "Authorization": "Bearer " + token])
                    .addHttpBody(Thunder.parserToData(from: payload)!)
                    .build()
    }
    
    private static func url() -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 5001
        components.path = "/bilge-85236/us-central1/graphql"
        
        return components.url!
    }
}

protocol Variable: Codable {}

protocol RequestGraphQl: Codable {
    associatedtype V: Variable
    
    var query: String { get }
    var variables: V? { get set }
}

struct Payload<T: Variable>: RequestGraphQl {
    var query: String
    var variables: T?
}
