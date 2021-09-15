//
//  ContentView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: AppModel
    
    var body: some View {
        if model.isLoggedIn {
            Text("Content")
        } else {
            Text("OnBoarding")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppModel())
    }
}
