//
//  StudentClassView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import SwiftUI
import Firebase

struct StudentClassView: View {
    @EnvironmentObject var store: AppStore
    @ObservedObject var viewModel: EnrolledCourseListViewModel
    @State var showClassroom = false
    
    var enrolled: EnrolledSectionM
    
    var body: some View {
        VStack {
            HStack {
                StudentWeekSelectorView(viewModel: viewModel)
                Spacer()
                VStack {
                    Text("Virtual room").font(.subheadline)
                    GButton(labelText: "Join", textColor: .white, color: .blue, fullWidth: true) {
                        showClassroom.toggle()
                    }
                    .frame(width: 100)
                }
                NavigationLink(isActive: $showClassroom) {
                    StudentClassroomView(viewModel: viewModel)
                } label: {
                    EmptyView()
                }

            }.padding()

            List {
                Section("Grades") {
                    NavigationLink {
                        VStack {
                            Text("Grades Details")
                            Text("Coming soon")
                        }
                    } label: {
                        gradeCell
                    }
                }
                
                Section("Contents") {
                    NavigationLink {
                        PDFKitRepresentedView(viewModel.pdfData ?? Data())
                            .onAppear {
                                let storage = Storage.storage()
                                let gsRef = storage.reference(forURL: "gs://bilge-85236.appspot.com/Indoividual Assignment - WorkContext Diagram JuanCombariza.pdf")
                                gsRef.getData(maxSize: Int64(1 * 1024 * 1024)) { data, error in
                                    if let error = error {
                                        // Uh-oh, an error occurred!
                                        print(error)
                                      } else {
                                        // Data for "images/island.jpg" is returned
                                          viewModel.pdfData = data
                                      }
                                }
                            }
                    } label: {
                        Text("Syllabus")
                    }
                    
                    NavigationLink {
                        ExamListView()
                    } label: {
                        Text("Exams")
                    }
                    
                    NavigationLink {
                        VStack {
                            Text("Quizzes details")
                            Text("Coming soon")
                        }
                    } label: {
                        Text("Quizzes")
                    }
                    
                    NavigationLink {
                        VStack {
                            Text("Assignments details")
                            Text("Coming soon")
                        }
                    } label: {
                        Text("Assignments")
                    }
                    
                    NavigationLink {
                        FileListView()
                    } label: {
                        Text("Files")
                    }
                }
                Section("Instructor") {
                    HStack {
                        Text("\(viewModel.instrunctorName)")
                        Spacer()
                        Button {
                            let appURL = URL(string: viewModel.email)!

                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(appURL)
                            }
                            //TODO: send email
                        } label: {
                            Image(systemName: "envelope.circle")
                                .resizable()
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(viewModel.courseName), displayMode: .inline)
        .onAppear {
            viewModel.store = store
            viewModel.instructor = enrolled.instructor
            viewModel.section = enrolled.section
            viewModel.course = enrolled.course
        }

    }
    
    var gradeCell: some View {
        HStack(alignment: .center) {
            
            Text("\(0) / 100")
                .padding(.horizontal, 20)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 25))
          
            Text("Current Grade")
        }.padding()
    }
}

struct StudentClassView_Previews: PreviewProvider {
    static var previews: some View {
        StudentClassView(viewModel: EnrolledCourseListViewModel(), enrolled: EnrolledSectionM())
    }
}
