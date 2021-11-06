//
//  TeacherView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI
import Firebase

struct TeacherView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        VStack {
            Text("Teacher")
            Button("log out") {
                let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
               } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
               }
            }
        }
    }
}

struct TeacherView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherView()
    }
}
