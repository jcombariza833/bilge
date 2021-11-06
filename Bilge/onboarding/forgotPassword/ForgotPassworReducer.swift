//
//  ForgotPassworReducer.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation
func forgotPasswordReducer(state: inout ForgotPasswordState, action: ForgotPasswordAction) -> Void {
    switch action {
    case .fetch( _ ):
        state.fetchError = nil
        state.fetchInProgress = true
    case .fetchSuccess:
        state.fetchInProgress = false
    case .fetchError(let errorMessage):
        state.fetchInProgress = false
        state.fetchError = errorMessage
    }
}
