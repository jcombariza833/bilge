//
//  ForgotPasswordView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/18/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = ""
    @State var isPresentedSnack = false

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        let resetErrorIsPresented =  Binding<Bool>(
            get: { store.state.forgotPassword.fetchError != nil },
            set: { _ in store.dispatch(.resetPassword(.fetchError(nil))) }
        )
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundColor(Color("noFocus"))
                        .font(Font.system(.largeTitle))
                })
            }.padding(.top, 30).padding(.trailing, 25)
            Spacer()
            VStack {
                Text("Enter your email and we will email you instructions on how to reset your password.")
                    .font(.system(.body))
                    .foregroundColor(Color("noFocus"))
                    .padding()
                EmailField(text: $email, helperText: nil, color: .blue)
            }.padding()
            
            Group {
                GButton(labelText: "Send", textColor: .white, color: .blue, fullWidth: true) {
                    store.dispatch(.resetPassword(.fetch(email)))
                }
                .frame(width: 280)
                
            }.padding()
            Spacer()
        }.snackBarPopUp(isPresented: resetErrorIsPresented,
                        labelText: store.state.forgotPassword.fetchError ?? "",
                        leadingIcon: "xmark.octagon",
                        textColor: .white,
                        color: .red)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
