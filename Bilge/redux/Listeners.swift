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
    return { state in
        return Auth.auth().iDTokenDidChangePublisher
            .map {
                .session(.token($0))
            }
            .eraseToAnyPublisher()
    }
}
