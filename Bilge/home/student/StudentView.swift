//
//  StudentView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI
import Firebase
import Thunder
import Combine

struct StudentView: View {
    @EnvironmentObject var store: AppStore
        
    var body: some View {
        VStack {
            Text("Student")
            Button("log out") {
                let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
               } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
               }
            }
            Button("request ") {
                store.dispatch(.session(.fetchUser("juan@gmail.com")))
            }
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
