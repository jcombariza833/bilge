//
//  InformationView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/21/21.
//

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var role = UserDefaults.standard.bool(forKey: "isStudent")
    
    @State var hasChanged = true
    @State private var username: String = ""
    @State private var name: String = ""
    @State private var lastName: String = ""
    
    let usernameCareTaker = TFCareTaker()
    let usernameOrganizator = TFOriginator(state: "")
    
    let nameCareTaker = TFCareTaker()
    let nameOrganizator = TFOriginator(state: "")
    
    let lastNameCareTaker = TFCareTaker()
    let lastNameOrganizator = TFOriginator(state: "")
    
    var body: some View {
        let updateProfileErrorIsPresented =  Binding<Bool>(
            get: { store.state.api.updateProfile.fetchError != nil },
            set: { _ in store.dispatch(.api(.updateProfile(.error(nil)))) }
        )
        
        List {
            Section("Information") {
                HStack {
                    Text("Username")
                    Spacer()
                    TextField("username", text: $username)
                        .font(.subheadline)
                        .lineLimit(1).multilineTextAlignment(.trailing)
                        .onChange(of: username) { newValue in
                            let usernamePredicate = newValue != usernameCareTaker.memento(by: 0).savedState()
                            let namePredicate = name != nameCareTaker.memento(by: 0).savedState()
                            let lastNamePredicate = lastName != lastNameCareTaker.memento(by: 0).savedState()
                            
                            hasChanged = !(namePredicate ||  lastNamePredicate || usernamePredicate)
                        }.disabled(role ? !((store.state.api.student?.username ?? "").isEmpty) : !((store.state.api.instructor?.username ?? "").isEmpty))

                }
                HStack {
                    Text("Email")
                    Spacer()
                    Text(role ? store.state.api.student?.email ?? "" :store.state.api.instructor?.email ?? "")
                        .lineLimit(1)
                        .font(.subheadline)
                }
                
                HStack {
                    Text("First")
                    Spacer()
                    TextField("Name", text: $name)
                        .font(.subheadline)
                        .lineLimit(1).multilineTextAlignment(.trailing)
                        .onChange(of: name) { newValue in
                            let namePredicate = newValue != nameCareTaker.memento(by: 0).savedState()
                            let lastNamePredicate = lastName != lastNameCareTaker.memento(by: 0).savedState()
                            let usernamePredicate = username != usernameCareTaker.memento(by: 0).savedState()
                            hasChanged = !(namePredicate ||  lastNamePredicate || usernamePredicate)
                        }
                }
                
                HStack {
                    Text("Last")
                    Spacer()
                    TextField("Lastname", text: $lastName)
                        .font(.subheadline)
                        .lineLimit(1).multilineTextAlignment(.trailing)
                        .onChange(of: lastName) { newValue in
                            let lastNamePredicate = newValue != lastNameCareTaker.memento(by: 0).savedState()
                            let namePredicate = name != nameCareTaker.memento(by: 0).savedState()
                            let usernamePredicate = username != usernameCareTaker.memento(by: 0).savedState()
                            hasChanged = !(namePredicate ||  lastNamePredicate || usernamePredicate)
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    let usernamePredicate = usernameCareTaker.memento(by: 0).savedState() == "" && !username.isEmpty
                    
                    let nameO = NameInput(fName: name,
                                         lName: lastName)
                    var profile = ProfileInput()
                    profile.name = nameO
                    if usernamePredicate { profile.username = username}
        
                    store.dispatch(.api(.updateProfile(.update(profile))))
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(hasChanged)
                .alert(store.state.api.updateProfile.fetchError ?? "", isPresented: updateProfileErrorIsPresented) {
                    Button("OK", role: .cancel) { }
                }
            }
        }
        .onAppear {
            if role {
                username = store.state.api.student?.username ?? ""
                name = store.state.api.student?.name.fName ?? ""
                lastName = store.state.api.student?.name.lName ?? ""
            } else {
                username = store.state.api.instructor?.username ?? ""
                name = store.state.api.instructor?.name.fName ?? ""
                lastName = store.state.api.instructor?.name.lName ?? ""
            }
           
            
            usernameOrganizator.setState(username)
            usernameCareTaker.add(memento: usernameOrganizator.saveToMemento())
            
            nameOrganizator.setState(name)
            nameCareTaker.add(memento: nameOrganizator.saveToMemento())
            
            lastNameOrganizator.setState(lastName)
            lastNameCareTaker.add(memento: lastNameOrganizator.saveToMemento())
        }
        .onDisappear {
            if role {
                store.dispatch(.api(.getStudent(.get)))
            } else {
                store.dispatch(.api(.getInstructor(.get)))
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
