//
//  HomeView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppStore
    private var role = UserDefaults.standard.bool(forKey: "isStudent")
    
    var body: some View {
        ZStack {
            if role {
                StudentView()
            } else {
                TeacherView()
            }
        }.onAppear {
            if role {
                store.dispatch(.api(.getStudent(.get)))
            } else {
                store.dispatch(.api(.getInstructor(.get)))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
