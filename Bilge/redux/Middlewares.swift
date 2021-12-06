//
//  Middlewares.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/2/21.
//

import Foundation
import Firebase
import Combine
import Apollo

struct MiddlewareManager {
    private let authenticationManager = AuthenticationManager()
    private let apiRepository = APIRepository()
    let middlewares: [Middleware<AppState, AppAction>]
    let listeners: [Listener<AppState, AppAction>]
    
    init() {
        self.middlewares = [authenticationMiddleware(authenticationManager),
                            apiMiddleware(apiRepository)]
        self.listeners = [loginStatusListener()]
    }
    
}
