//
//  SignUpView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI
import MyComponents

struct SignUpView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var store: AppStore
    
    enum Field {
        case username
        case email
        case password
    }
    
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State private var isOn = false
    @State var isHidde = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        let registrationErrorIsPresented =  Binding<Bool>(
            get: { store.state.session.fetchError != nil },
            set: { _ in store.dispatch(.login(.fetchError(nil))) }
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
                GTextField(text: $username, labelText: "Username", leadingIcon: "person", trailingIcon: "clear", trailingIconAction: {
                    username = ""
                }, color: .blue)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                EmailField(text: $email, helperText: nil, color: .blue)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                PasswordField(text: $password, helperText: nil, color: .blue)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.send)
                
                GToggle(colorOn: .blue, isOn: $isOn) {
                    HStack {
                        Spacer()
                        Text("Are you a Student?")
                            .font(.system(.caption))
                            .foregroundColor(Color("noFocus"))
                    }
                }
                .frame(width: 280)
            }
            .onSubmit {
                switch focusedField {
                case .username:
                    focusedField = .email
                case .email:
                    focusedField = .password
                default:
                    print("Creating account…")
                }
            }
            .padding()
            
            Group {
                GButton(labelText: "Sign Up", textColor: .white, color: .blue, fullWidth: true) {
                    store.dispatch(.registration(.fetch((username,email,password, isOn))))
                }
                .frame(width: 280)
                
                HStack {
                    Text("Already have an account?")
                    GLink(labelText: "Sing In", inactiveColor: .blue) {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }.padding()
            Spacer()
        }.snackBarPopUp(isPresented: registrationErrorIsPresented,
                        labelText: store.state.session.fetchError ?? "",
                        leadingIcon: "xmark.octagon",
                        textColor: .white,
                        color: .red)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
