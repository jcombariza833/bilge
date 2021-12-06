//
//  ForgotPasswordState.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation

struct ForgotPasswordState {
    var fetchError: String?
    var fetchInProgress: Bool = false
    
    var fetchUpdateError: String?
    var fetchInUpdateProgress: Bool = false
}
