//
//  SignInAction.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/6/21.
//

import Foundation
import Firebase

enum SignInAction {
    typealias Email = String
    typealias Password = String
    typealias Uid = String
    typealias payload = (Email, Password)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess(Uid)
    case fetchError(errorMessage)
}
