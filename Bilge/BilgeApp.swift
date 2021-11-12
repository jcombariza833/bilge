//
//  BilgeApp.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI
import Firebase

@main
struct BilgeApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        UserDefaults.standard.register(defaults: ["isStudent" : false])
        let authenticationManager = AuthenticationManager()
        
        let appState = AppState(session: SessionState(account: AccountState()),
                                forgotPassword: ForgotPasswordState())
        
        let appStore = AppStore(initial: appState,
                                reducer: appReducer,
                                middlewares: [authenticationMiddleware(authenticationManager),
                                             apiMiddleware()],
                                listeners: [loginStatusListener()])
        
        return WindowGroup {
            ContentView()
                .environmentObject(appStore)
        }
    }
}
