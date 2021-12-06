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
    var pollManger = PollManger()
    
    init() {
        FirebaseApp.configure()
        Auth.auth().useEmulator(withHost:"localhost", port:9099)
    }

    var body: some Scene {
        UserDefaults.standard.register(defaults: ["token" : "",
                                                  "role":false,
                                                  "isStudent": false]
        )
        let middlewareManager = MiddlewareManager()
        let appStateFacrory = AppStateFactory()
        
        let appStore = AppStore(initial: appStateFacrory.createAppState(),
                                reducer: appReducer,
                                middlewares: middlewareManager.middlewares,
                                listeners: middlewareManager.listeners)
        
        return WindowGroup {
            ContentView()
                .environmentObject(appStore)
                .environmentObject(pollManger)
                .onAppear {
                    let polls = PersistenceController.shared.getAllPolls()
                    let pollsMapped = polls.map {PollManger.invert($0)}
                    
                    print(pollsMapped)
                }
        }
    }
}
