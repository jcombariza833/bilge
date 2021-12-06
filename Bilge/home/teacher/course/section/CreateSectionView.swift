//
//  CreateSectionView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/4/21.
//

import SwiftUI

struct CreateSectionView: View {
    
    struct AlertDetails: Identifiable {
        var id: String { message }
        let message: String
    }
    
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var schedule = ScheduleViewModel()
    
    @State var code = ""
    @State var isActive = false
    @State var showAlert = false
    @State var details: AlertDetails?
    @State var maxStudent = 1
    
    var course: CourseM

    var username: String {
        get { store.state.api.instructor?.username ?? ""}
    }
    
    var body: some View {
        NavigationView {
            List {
            
                HStack {
                    Text("Code")
                    Spacer()
                    TextField("code", text: $code)
                        .font(.subheadline)
                        .lineLimit(1).multilineTextAlignment(.trailing)

                }
                HStack {
                    Text("Public")
                    Spacer()
                    GToggle(colorOn: .blue, isOn: $isActive) {
                        HStack {
                            Spacer()
                            
                            Text("students will see this section")
                                .font(.system(.caption))
                                .foregroundColor(Color("noFocus"))
                        }
                    }
                }
                
                Stepper("Number of students: \(maxStudent)", value: $maxStudent, in: (1...100))
                
                NavigationLink {
                    ScheduleView(viewModel: schedule)
                } label: {
                    Text("Schedule")
                }

                HStack {
                    Spacer()
                    addButton
                    Spacer()
                }.padding()
            }
            .navigationTitle("Create Section")
            .onChange(of: store.state.api.createSectionError, perform: { newValue in
                if let message = newValue {
                    details = AlertDetails(message: message)
                    showAlert.toggle()
                    store.dispatch(.api(.createSection(.error(nil))))
                }
            })
            .onDisappear {
                store.dispatch(.api(.getInstructor(.get)))
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            if code.isEmpty {
                details = AlertDetails(message: "Code field connot be empty")
                showAlert.toggle()
            } else if username.isEmpty {
                details = AlertDetails(message: "Set a unique username before create courses")
                showAlert.toggle()
            } else {
                
                let schedules = schedule.schedules.map {
                    ScheduleInput(day: $0.day, isActive: $0.isActive, classroom: $0.classroom)
                }
                let section = SectionInput(isActive: isActive,
                                           code: code,
                                           schedule: schedules,
                                           maxStudents: maxStudent)
                
                store.dispatch(.api(.createSection(.create(section, course.code))))
            }
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.body)
                    .padding(.all, 4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("Add Section")
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

struct CreateSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSectionView(course: CourseM())
    }
}
