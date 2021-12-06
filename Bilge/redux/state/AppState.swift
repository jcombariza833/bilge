//
//  State.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/1/21.
//

import Foundation
import Firebase

struct AppState {
    var session: SessionState
    var forgotPassword: ForgotPasswordState
    var api: APIState
}
