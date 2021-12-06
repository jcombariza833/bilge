//
//  SignUpView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var store: AppStore
    
    enum Field {
        case email
        case password
    }
    
    @State var email = ""
    @State var password = ""
    @State var isStudent = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        let registrationErrorIsPresented =  Binding<Bool>(
            get: { store.state.session.singUp.fetchError != nil },
            set: { _ in store.dispatch(.registration(.fetchError(nil))) }
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
                EmailField(text: $email, helperText: nil, color: .blue)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                PasswordField(text: $password, helperText: nil, color: .blue)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.send)
                
                GToggle(colorOn: .blue, isOn: $isStudent) {
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
                case .email:
                    focusedField = .password
                default:
                    print("Creating account…")
                }
            }
            .padding()
            
            Group {
                GButton(labelText: "Sign Up", textColor: .white, color: .blue, fullWidth: true) {
                    UserDefaults.standard.set(isStudent, forKey: "isStudent")
                    let role: RoleType = isStudent ? .student : .insturctor
                    store.dispatch(.registration(.fetch((email,password, role))))
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
        }
        .alert(store.state.session.singUp.fetchError ?? "", isPresented: registrationErrorIsPresented) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
