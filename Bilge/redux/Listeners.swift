//
//  Listeners.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation
import Firebase
import Combine

func loginStatusListener() -> Listener<AppState, AppAction> {
    Auth.auth()
    return { state in
        return Auth.auth().iDTokenDidChangePublisher
            .map {
                .session(.updateLogginStatus($0 != nil, $0))
            }
            .eraseToAnyPublisher()
    }
}
