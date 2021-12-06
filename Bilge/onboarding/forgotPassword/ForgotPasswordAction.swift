//
//  ForgotPasswordAction.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation

enum ForgotPasswordAction {
    typealias Email = String
    typealias payload = (Email)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess
    case fetchError(errorMessage)
}
