//
//  Actions.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/1/21.
//

import Foundation
import Combine
import SwiftUI
import Firebase


enum AppAction {
    case session(SessionAction)
    case login(SignInAction)
    case registration(SignUpAction)
    case resetPassword(ForgotPasswordAction)
}

enum SessionAction {
    typealias logginStatus = Bool
    typealias errorMessage = String?
    
    case updateLogginStatus(logginStatus, User?)
    
    case fetchAccessToken(User)
    case fetchSuccessAccessToken(String)
    case fetchAccessTokenError(errorMessage)
    
    case signOut
    case signOutSuccess
    case signOutError(errorMessage)
}
