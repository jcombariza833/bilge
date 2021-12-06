//
//  AuthenticationManager.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/1/21.
//

import Foundation
import Combine
import Firebase

final class AuthenticationManager: AuthenticationService {

    func registration(email: String, password: String) -> AnyPublisher<User, AuthError> {
        return Future<User,AuthError> { promise in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    return promise(.failure(.firebaseError(error.localizedDescription)))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<User,AuthError> {
        return Future<User,AuthError> { promise in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    return promise(.failure(.firebaseError(error.localizedDescription)))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func sendForgorPasswordEmail(email: String) -> AnyPublisher<Void,AuthError> {
        return Future<Void,AuthError> { promise in
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    return promise(.failure(.firebaseError(error.localizedDescription)))
                }
                return promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func updatePassword(password: String) -> AnyPublisher<Void, AuthError> {
        return Future<Void,AuthError> { promise in
            guard let user = Auth.auth().currentUser else {
                return promise(.failure(.firebaseError("user is not logged")))
            }
            user.updatePassword(to: password) { error in
                if let error = error {
                    return promise(.failure(.firebaseError(error.localizedDescription)))
                }
                return promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func token(user: User?) -> AnyPublisher<String,AuthError> {
        return Future<String, AuthError> { promise in
            guard let user = user else {
                return promise(.failure(.firebaseError("error retreaving id Token")))
            }
            
            user.getIDToken { token, error in
                
                guard let token = token, error == nil else {
                    if let error = error {
                        return promise(.failure(.firebaseError(error.localizedDescription)))
                    }
                    
                    return promise(.failure(.firebaseError("error retreaving id Token")))
                }
                
                return promise(.success(token))
            }
        }.eraseToAnyPublisher()
    }
    
    func singOut() -> AnyPublisher<Void,AuthError> {
        return Future<Void, AuthError> { promise in
            do{
                try Auth.auth().signOut()
            } catch let error {
                return promise(.failure(.firebaseError(error.localizedDescription)))
            }
            return promise(.success(()))
        }.eraseToAnyPublisher()
    }
}
