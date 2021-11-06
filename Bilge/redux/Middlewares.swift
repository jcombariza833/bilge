//
//  Middlewares.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/2/21.
//

import Foundation
import Firebase
import Combine

func authenticationMiddleware(_ authenticationManager: AuthenticationService) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
            
            // MARK: - Login
        case .login(.fetch(let payload)):
            let (email, password, isStudent) = payload
            return authenticationManager.login(email: email, password: password)
                .subscribe(on: DispatchQueue.main)
                .map {
                    .login(.fetchSuccess($0, isStudent))
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.login(.fetchError(message)))
                    }
                }.eraseToAnyPublisher()
            
            // MARK: - registration
        case .registration(.fetch(let payload)):
            let (username, email, password, isStudent) = payload
            return authenticationManager.registration(email: email, password: password)
                .subscribe(on: DispatchQueue.main)
                .map {
                    .registration(.fetchSuccess($0, isStudent))
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
            
            // MARK: - request token
        case .session(.updateLogginStatus(_ , let user)):
            guard let user = user else {
                return Just(.session(.fetchAccessTokenError("error retreaving id Token"))).eraseToAnyPublisher()
            }
            
            return Just(.session(.fetchAccessToken(user))).eraseToAnyPublisher()
            
        case .session(.fetchAccessToken(let user)):
            return authenticationManager.token(user: user)
                .subscribe(on: DispatchQueue.main)
                .map {
                    .session(.fetchSuccessAccessToken($0))
                }.catch { (error: AuthError) -> Just<AppAction> in
                    switch error {
                    case .firebaseError(let message):
                        return Just(.session(.fetchAccessTokenError(message)))
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
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}


