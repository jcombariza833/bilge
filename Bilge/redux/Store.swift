//
//  Store.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/1/21.
//

import Foundation
import Combine
import Firebase

typealias AppStore = Store<AppState, AppAction>

class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    private let listeners: [Listener<State, Action>]
    private var subscriptions: Set<AnyCancellable> = []

    init(initial: State,
         reducer: @escaping Reducer<State, Action>,
         middlewares: [Middleware<State, Action>] = [],
         listeners: [Listener<State, Action>] = []) {
        self.state = initial
        self.reducer = reducer
        self.middlewares = middlewares
        self.listeners = listeners
        
        self.listeners.forEach { listener in
            let publisher = listener(state)
            
            publisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }
    }
    
    func dispatch(_ action: Action) {
        reducer(&state, action)
        
        middlewares.forEach { middleware in
            let publisher = middleware(state, action)
            
            publisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }
    }
}

extension AppStore {
    static let mock = AppStore(initial:
                                AppState(session: SessionState(singUp: SignUpState(),
                                                               singIn: SignInState()),
                                        forgotPassword: ForgotPasswordState(),
                                         api: APIState(updateProfile: APIUpdateProfileState())),
                               reducer: appReducer(state:action:))
}
