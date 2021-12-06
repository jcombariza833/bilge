//
//  CreateCourseView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/3/21.
//

import SwiftUI

struct CreateCourseView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name = ""
    @State var code = ""
    @State var description = ""
    
    @State var showAlert = false
    @State var details: CreateDetails?
    
    var username: String {
        get { store.state.api.instructor?.username ?? ""}
    }
    
    struct CreateDetails: Identifiable {
        var id: String { message }
        let message: String
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("name", text: $name)
                        .font(.subheadline)
                        .lineLimit(1).multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Code")
                    Spacer()
                    TextField("code", text: $code)
                        .font(.subheadline)
                        .lineLimit(1).multilineTextAlignment(.trailing)

                }
                
                VStack {
                    HStack {
                        Text("Description")
                        Spacer()
                    }
                    
                    TextEditor(text: $description)
                        .font(.subheadline)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .frame(height: 150)
                }
                HStack {
                    Spacer()
                    addButton
                    Spacer()
                }.padding()
            }
            .navigationTitle("Create Course")
            .onChange(of: store.state.api.createCourseError, perform: { newValue in
                if let message = newValue {
                    details = CreateDetails(message: message)
                    showAlert.toggle()
                    store.dispatch(.api(.createCourse(.error(nil))))
                }
            })
            .onDisappear {
                store.dispatch(.api(.getInstructor(.get)))
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            if name.isEmpty || code.isEmpty || description.isEmpty {
                details = CreateDetails(message: "All the field must be filled out")
                showAlert.toggle()
            } else if username.isEmpty {
                details = CreateDetails(message: "Set a unique username before create courses")
                showAlert.toggle()
            } else {
                let course = CourseInput(name: name, description: description, code: code)
                store.dispatch(.api(.createCourse(.create(course))))
            }
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.body)
                    .padding(.all, 4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("Add Course")
                    .font(.body)
                    .foregroundColor(.blue)
            }
        }
        .alert("", isPresented: $showAlert, presenting: details) { detail in
            Button("OK", role: .cancel) {
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: { detail in
            Text(detail.message)
        }
    }
}

struct CreateCourseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCourseView()
    }
}
