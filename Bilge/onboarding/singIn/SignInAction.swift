//
//  SignInAction.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/6/21.
//

import Foundation
import Firebase

enum SignInAction {
    typealias payload = (String, String, Bool)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess(User, Bool)
    case fetchError(errorMessage)
}
