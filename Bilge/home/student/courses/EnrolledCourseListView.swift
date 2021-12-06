//
//  EnrolledCourseListView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import SwiftUI

struct EnrolledCourseListView: View {
    @EnvironmentObject var store: AppStore
    @StateObject var viewModel: EnrolledCourseListViewModel = EnrolledCourseListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.enrolledClasses)  { enrolled in
                    NavigationLink {
                        StudentClassView(viewModel: viewModel, enrolled: enrolled)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(enrolled.course.name).bold()
                            Text("\(enrolled.course.code) - \(enrolled.section.code)")
                                .font(.caption)
                        }.padding()
                    }
                }.onDelete { indexSet in
                    indexSet.forEach { i in
                        let enrolled = viewModel.enrolledClasses[i]
                        let sectionCode = enrolled.section.code
                        store.dispatch(.api(.unenrollClass(.unenroll(sectionCode))))
                    }
                    viewModel.enrolledClasses.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Courses")
            .onAppear {
                viewModel.store = store
                viewModel.enrolledClasses = viewModel.enrolledClassesCaller
            }
        }
    }
}

struct EnrolledCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        EnrolledCourseListView()
    }
}
