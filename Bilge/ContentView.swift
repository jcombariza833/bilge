//
//  ContentView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        if store.state.session.isLoggedIn {
            HomeView()
        } else {
            OnBoardingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppStore.mock)
    }
}
