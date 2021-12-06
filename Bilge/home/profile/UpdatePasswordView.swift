//
//  UpdatePasswordView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/21/21.
//

import SwiftUI

struct UpdatePasswordView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var hasChanged = true
    @State private var password = ""
    @State var showPassword = false
    
    let passwordCareTaker = TFCareTaker()
    let passswordOrganizator = TFOriginator(state: "")
    
    var body: some View {
        let updatePasswordErrorIsPresented =  Binding<Bool>(
            get: { store.state.forgotPassword.fetchUpdateError != nil },
            set: { _ in store.dispatch(.updatePassword(.fetchError(nil))) }
        )
        List {
            HStack {
                Text("Password")
                Spacer()
                HStack {
                    if showPassword {
                        TextField("Enter", text: $password)
                            .font(.subheadline)
                            .lineLimit(1).multilineTextAlignment(.trailing)
                            .onChange(of: password) { newValue in
                                if newValue != passwordCareTaker.memento(by: 0).savedState() {
                                    hasChanged = false
                                } else {
                                    hasChanged = true
                                }
                            }
                    } else {
                        SecureField("Enter", text: $password)
                            .font(.subheadline)
                            .lineLimit(1).multilineTextAlignment(.trailing)
                            .onChange(of: password) { newValue in
                                if newValue != passwordCareTaker.memento(by: 0).savedState() {
                                    hasChanged = false
                                } else {
                                    hasChanged = true
                                }
                            }
                    }
                    
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showPassword.toggle()
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        print("Pressed")
                    }.disabled(hasChanged)
                        .alert(store.state.forgotPassword.fetchUpdateError ?? "", isPresented: updatePasswordErrorIsPresented) {
                        Button("OK", role: .cancel) { }
                    }
                }
            }
            .onAppear {
                passswordOrganizator.setState(password)
                passwordCareTaker.add(memento: passswordOrganizator.saveToMemento())
            }
        }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}
