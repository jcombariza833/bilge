//
//  Reducer.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/2/21.
//

import Foundation
import Firebase

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .registration(let signUpAction):
        signUpReducer(state: &state.session, action: signUpAction)
    case .login(let signInAction):
        signInReducer(state: &state.session, action: signInAction)
    case .session(let sessionAction):
        sessionReducer(state: &state.session, action: sessionAction)
    case .resetPassword(let forgotPasswordAction):
        forgotPasswordReducer(state: &state.forgotPassword, action: forgotPasswordAction)
    }
}

func sessionReducer(state: inout SessionState, action: SessionAction) -> Void {
    switch action {
    case .updateLogginStatus(let status, _ ):
        state.isLoggedIn = status
        if(!state.isLoggedIn) {
            state.token = ""
            state.user = nil
        }
    case .fetchAccessToken:
        state.fetchAccessTokenError = nil
        state.fetchActionTokenInProgress = true
    case .fetchSuccessAccessToken(let token):
        state.fetchActionTokenInProgress = false
        state.token = token
    case .fetchAccessTokenError(let error):
        state.fetchActionTokenInProgress = false
        state.fetchAccessTokenError = error
    case .signOut:
        state.signOutError = nil
        state.signOutInProgress = true
    case .signOutSuccess:
        state.signOutInProgress = false
        state.token = ""
        state.user = nil
    case .signOutError(let error):
        state.signOutInProgress = false
        state.signOutError = error
    }
}
