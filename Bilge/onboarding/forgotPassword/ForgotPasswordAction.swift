//
//  ForgotPasswordAction.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation

enum ForgotPasswordAction {
    typealias payload = (String)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess
    case fetchError(errorMessage)
}
