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
        let authenticationManager = AuthenticationManager()
        
        let appState = AppState(session: SessionState(account: AccountState()),
                                forgotPassword: ForgotPasswordState())
        
        let appStore = AppStore(initial: appState,
                                reducer: appReducer,
                                middlewares: [authenticationMiddleware(authenticationManager)],
                                listeners: [loginStatusListener()])
        
        return WindowGroup {
            ContentView()
                .environmentObject(appStore)
        }
    }
}
