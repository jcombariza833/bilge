//
//  TokenAddingInterceptor.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/12/21.
//

import Foundation
import Apollo

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        if let token = UserDefaults.standard.string(forKey: "token"), token != "" {
            request.addHeader(name: "Authorization", value: "Bearer " + token)
        } 
                    
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}

