//
//  SignInReducer.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/6/21.
//

import Foundation

func signInReducer(state: inout SessionState, action: SignInAction) -> Void {
    switch action {
    case .fetch( _ ):
        state.fetchError = nil
        state.fetchInProgress = true
    case .fetchSuccess(let user, let isStudent):
        state.fetchInProgress = false
        state.user = user
        UserDefaults.standard.set(isStudent, forKey: "isStudent")
        state.account.isStudent = UserDefaults.standard.bool(forKey: "isStudent")
    case .fetchError(let errorMessage):
        state.fetchInProgress = false
        state.fetchError = errorMessage
    }
}
