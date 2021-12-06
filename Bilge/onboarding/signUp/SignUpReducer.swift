//
//  SignUpReducer.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation

func signUpReducer(state: inout SessionState, action: SignUpAction) -> Void {
    switch action {
    case .fetch( _ ):
        state.singUp.fetchError = nil
        state.singUp.fetchInProgress = true
    case .fetchSuccess(let uid, let role):
        state.singUp.fetchInProgress = false
        state.uid = uid
        state.role = role
    case .fetchError(let errorMessage):
        state.singUp.fetchInProgress = false
        state.singUp.fetchError = errorMessage
    }
}
