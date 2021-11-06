//
//  HomeView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        if store.state.session.account.isStudent {
            StudentView()
        } else {
           TeacherView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
