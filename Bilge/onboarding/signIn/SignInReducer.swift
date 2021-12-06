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
        state.singIn.fetchError = nil
        state.singIn.fetchInProgress = true
    case .fetchSuccess(let uid):
        state.singIn.fetchInProgress = false
        state.uid = uid
    case .fetchError(let errorMessage):
        state.singIn.fetchInProgress = false
        state.singIn.fetchError = errorMessage
    }
}
