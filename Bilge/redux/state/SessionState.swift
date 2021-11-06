//
//  SessionState.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/4/21.
//

import Foundation
import Firebase

struct SessionState {
    var isLoggedIn = false
    var user: User?
    var token = ""
    var account: AccountState
    
    var fetchError: String?
    var fetchInProgress: Bool = false
    
    var fetchAccessTokenError: String?
    var fetchActionTokenInProgress: Bool = false
    
    var signOutError: String?
    var signOutInProgress: Bool = false
}
