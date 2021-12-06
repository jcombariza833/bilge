//
//  ClassView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/5/21.
//

import SwiftUI
import Firebase

struct ClassView: View {
    @EnvironmentObject var store: AppStore
    @StateObject var viewModel = ClassViewModel()
    @State var showClassroom = false
    
    var course: CourseM
    var section: SectionM
    
    var body: some View {
        VStack {
            HStack {
                WeekSelectorView(viewModel: viewModel)
                Spacer()
                VStack {
                    Text("Virtual room").font(.subheadline)
                    GButton(labelText: "Join", textColor: .white, color: .blue, fullWidth: true) {
                        showClassroom.toggle()
                    }
                    .frame(width: 100)
                }
                NavigationLink(isActive: $showClassroom) {
                    ClassroomView(viewModel: viewModel)
                } label: {
                    EmptyView()
                }

            }.padding()

            List {
                Section("Grades") {
                    NavigationLink {
                        VStack {
                            Text("Grades Details")
                            Text("Coming soons")
                        }
                    } label: {
                        gradeCell
                    }
                }
                
                Section("Contents") {
                    NavigationLink {
                        PDFKitRepresentedView(viewModel.data ?? Data())
                            .onAppear {
                                let storage = Storage.storage()
                                let gsRef = storage.reference(forURL: "gs://bilge-85236.appspot.com/Indoividual Assignment - WorkContext Diagram JuanCombariza.pdf")
                                gsRef.getData(maxSize: Int64(1 * 1024 * 1024)) { data, error in
                                    if let error = error {
                                        // Uh-oh, an error occurred!
                                        print(error)
                                      } else {
                                        // Data for "images/island.jpg" is returned
                                          viewModel.data = data
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
                        Text("\(viewModel.name)")
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
        .navigationBarTitle(Text(course.name), displayMode: .inline)
        .onAppear {
            viewModel.store = store
            viewModel.course = course
            viewModel.section = section
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

struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView(course: CourseM(), section: SectionM())
    }
}
