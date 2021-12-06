//
//  StateFactory.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/1/21.
//

import Foundation

struct AppStateFactory {
    func createAppState() -> AppState {
        let session = SessionState(singUp: SignUpState(),
                                   singIn: SignInState())
        let api = APIState(updateProfile: APIUpdateProfileState())
        let appState = AppState(session: session,
                                forgotPassword: ForgotPasswordState(),
                                api: api)
        
        return appState
    }
}
