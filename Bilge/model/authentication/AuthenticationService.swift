//
//  AuthenticationService.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/20/21.
//

import Foundation
import Combine
import FirebaseAuth
 

enum AuthError: Error {
    case firebaseError(String)
}
protocol AuthenticationService {
    func registration(email: String, password: String) -> AnyPublisher<User,AuthError>
    func login(email: String, password: String) -> AnyPublisher<User,AuthError>
    func sendForgorPasswordEmail(email: String) -> AnyPublisher<Void,AuthError>
    func updatePassword(password: String) -> AnyPublisher<Void,AuthError>
    func token(user: User?) -> AnyPublisher<String,AuthError>
    func singOut() -> AnyPublisher<Void,AuthError>
}
