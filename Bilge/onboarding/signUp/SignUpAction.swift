//
//  SignUpAction.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation
import Firebase

enum SignUpAction {
    typealias Email = String
    typealias Password = String
    typealias Uid = String
    typealias Role = RoleType
    typealias payload = (Email, Password, Role)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess(Uid, Role)
    case fetchError(errorMessage)
}
