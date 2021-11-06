//
//  StateDidChangePublisher.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation
import Combine
import Firebase

extension Auth {
    struct IDTokenDidChangePublisher: Combine.Publisher {
        typealias Output = User?
        typealias Failure = Never
            
        private let auth: Auth
            
        init(_ auth: Auth) {
            self.auth = auth
        }
            
        func receive<S>(subscriber: S) where S : Subscriber, IDTokenDidChangePublisher.Failure == S.Failure, IDTokenDidChangePublisher.Output == S.Input {
            let subscription = User.IDTokenDidChangeSubscription(subcriber: subscriber, auth: auth)
            subscriber.receive(subscription: subscription)
        }
    }
        
    public var iDTokenDidChangePublisher: AnyPublisher<User?, Never> {
        IDTokenDidChangePublisher(self)
            .eraseToAnyPublisher()
    }
}

extension User {
    fileprivate final class IDTokenDidChangeSubscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input == User? {
        
        var handler: IDTokenDidChangeListenerHandle?
        var auth: Auth?

        init(subcriber: SubscriberType, auth: Auth) {
            self.auth = auth
            handler = auth.addIDTokenDidChangeListener { (_, user) in
                _ = subcriber.receive(user)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {
            // We do nothing here as we only want to send events when they occur.
            // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
        }
        
        func cancel() {
            if let handler = handler {
                auth?.removeIDTokenDidChangeListener(handler)
            }
            handler = nil
            auth = nil
        }
    }
}
