//
//  ProfileView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/20/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var store: AppStore
    
    private var role = UserDefaults.standard.bool(forKey: "isStudent")
   
    var body: some View {
        NavigationView {
            List {
                VStack {
                    HStack {
                        Spacer()
                        ProfileImageView()
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Text(role ? store.state.api.student?.name.fName ?? "" : store.state.api.instructor?.name.fName ?? "").bold()
                            Text(role ? store.state.api.student?.name.lName ?? "" : store.state.api.instructor?.name.lName ?? "").bold()
                        }
                        Text(role ? store.state.api.student?.email ?? "" : store.state.api.instructor?.email ?? "").font(.subheadline)
                        Text(role ? "Student" : "Instructor").font(.subheadline)
                    }.padding(.top)
                }.padding()
                
                Section {
                    NavigationLink {
                        InformationView()
                    } label: {
                        Text("Information")
                    }
                    
                    NavigationLink {
                        SecurityView()
                    } label: {
                        Text("Security")
                    }
                }
                
                HStack {
                    Spacer()
                    Button {
                        store.dispatch(.session(.signOut))
                    } label: {
                        Text("Sign Out").foregroundColor(.red)
                    }

                    Spacer()
                }
            }
            .navigationTitle("Profile")
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
