//
//  AuthenticationMiddleware.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/1/21.
//

import Foundation
import Firebase
import Combine
import Apollo

func authenticationMiddleware(_ authenticationManager: AuthenticationService) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
            
            // MARK: - Login
        case .login(.fetch(let payload)):
            let (email, password) = payload
            return authenticationManager.login(email: email, password: password)
                .subscribe(on: DispatchQueue.main)
                .map {
                    .login(.fetchSuccess($0.uid))
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.login(.fetchError(message)))
                    }
                }.eraseToAnyPublisher()
            
            // MARK: - registration
        case .registration(.fetch(let payload)):
            let (email, password, role) = payload
            return authenticationManager.registration(email: email, password: password)
                .subscribe(on: DispatchQueue.main)
                .map {
                    UserDefaults.standard.set(false, forKey: "role")
                    return .registration(.fetchSuccess($0.uid, role))
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.registration(.fetchError(message)))
                    }
                }.eraseToAnyPublisher()
            
            // MARK: - resetPassport
        case .resetPassword(.fetch(let email)):
            return authenticationManager.sendForgorPasswordEmail(email: email)
                .subscribe(on: DispatchQueue.main)
                .map {
                    .resetPassword(.fetchSuccess)
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.resetPassword(.fetchError(message)))
                    }
                }.eraseToAnyPublisher()
            
            // MARK: - updatePassport
        case .updatePassword(.fetch(let password)):
            return authenticationManager.updatePassword(password: password)
                .subscribe(on: DispatchQueue.main)
                .map {
                    .updatePassword(.fetchSuccess)
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.updatePassword(.fetchError(message)))
                    }
                }.eraseToAnyPublisher()
            // MARK: - request token
        case .session(.token(let user)):
            return authenticationManager.token(user: user).subscribe(on: DispatchQueue.main)
                .map {
                    .session(.tokenUpdated($0))
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.session(.tokenError(message)))
                    }
                }.eraseToAnyPublisher()
            
        case .session(.signOut):
            return authenticationManager.singOut().subscribe(on: DispatchQueue.main)
                .map {
                    .session(.signOutSuccess)
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.session(.signOutError(message)))
                    }
                }.eraseToAnyPublisher()
        case .session(.tokenUpdated(_)):
            return Just(.api(.updateRole(.update(state.session.role)))).eraseToAnyPublisher()
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
