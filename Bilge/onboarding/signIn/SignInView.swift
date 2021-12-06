//
//  SignInView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI
import Combine

struct SignInView: View {
    @EnvironmentObject var store: AppStore
    
    @State var email = ""
    @State var password = ""
    @State var isSigningUp = false
    @State var isForgotPassword = false
    
    var body: some View {
        let logginErrorIsPresented =  Binding<Bool>(
            get: { store.state.session.singIn.fetchError != nil },
            set: { _ in store.dispatch(.login(.fetchError(nil))) }
        )
        
        VStack {
            VStack {
                EmailField(text: $email, helperText: nil, color: .blue)
                PasswordField(text: $password, helperText: nil, color: .blue)
            }.padding()
            
            Group {
                GButton(labelText: "Sign In", textColor: .white, color: .blue, fullWidth: true) {
                    store.dispatch(.login(.fetch((email, password))))
                }
                .frame(width: 280)
                
                GLink(labelText: "Forgot password?", activeColor: .blue) {
                    isForgotPassword.toggle()
                }.sheet(isPresented: $isForgotPassword) {
                    if store.state.forgotPassword.fetchInProgress {
                        ProgressView()
                    } else {
                        ForgotPasswordView()
                    }
                }
                
                HStack {
                    Text("Don't have an account?")
                    GLink(labelText: "Sing Up", inactiveColor: .blue) {
                        isSigningUp.toggle()
                    }.sheet(isPresented: $isSigningUp) {
                        if store.state.session.singUp.fetchInProgress {
                            ProgressView()
                        } else {
                            SignUpView()
                        }
                    }
                }
            }.padding()
        }.alert(store.state.session.singIn.fetchError ?? "", isPresented: logginErrorIsPresented) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(AppStore.mock)
    }
}
