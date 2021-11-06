//
//  SignInView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI
import Combine
import MyComponents

struct SignInView: View {
    @EnvironmentObject var store: AppStore
    
    @State var email = ""
    @State var password = ""
    @State var isPresentedSnack = false
    @State var isOn = false
    @State var isSigningUp = false
    @State var isForgotPassword = false
    
    var body: some View {
        let logginErrorIsPresented =  Binding<Bool>(
            get: { store.state.session.fetchError != nil },
            set: { _ in store.dispatch(.login(.fetchError(nil))) }
        )
        
        VStack {
            VStack {
                EmailField(text: $email, helperText: nil, color: .blue)
                PasswordField(text: $password, helperText: nil, color: .blue)
                
                GToggle(colorOn: .blue, isOn: $isOn) {
                    HStack {
                        Spacer()
                        Text("Are you a Student?")
                            .font(.system(.caption))
                            .foregroundColor(Color("noFocus"))
                    }
                }
                .frame(width: 280)
            }.padding()
            
            Group {
                GButton(labelText: "Sign In", textColor: .white, color: .blue, fullWidth: true) {
                    store.dispatch(.login(.fetch((email, password, isOn))))
                }
                .frame(width: 280)
                
                GLink(labelText: "Forgot password?", activeColor: .blue) {
                    isForgotPassword.toggle()
                }.sheet(isPresented: $isForgotPassword) {
                    ForgotPasswordView()
                }
                
                HStack {
                    Text("Don't have an account?")
                    GLink(labelText: "Sing Up", inactiveColor: .blue) {
                        isSigningUp.toggle()
                    }.sheet(isPresented: $isSigningUp) {
                        SignUpView()
                    }
                }
            }.padding()
        }.snackBarPopUp(isPresented: logginErrorIsPresented,
                        labelText: store.state.session.fetchError ?? "",
                        leadingIcon: "xmark.octagon",
                        textColor: .white,
                        color: .red)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(AppStore.mock)
    }
}
