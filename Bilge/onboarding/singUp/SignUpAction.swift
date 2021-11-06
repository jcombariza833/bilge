//
//  SignUpAction.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation
import Firebase

enum SignUpAction {
    typealias payload = (String, String, String, Bool)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess(User, Bool)
    case fetchError(errorMessage)
}
