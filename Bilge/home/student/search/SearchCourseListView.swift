//
//  SearchCourseListView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchCourseListView: View {
    @EnvironmentObject var store: AppStore
    
    @State private var searchText = ""
    @State var enrollingInProgress = false
    
    var username: String
    
    var courses: [CourseM] {
        get { store.state.api.selectedInstructor?.courses ?? [CourseM]() }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResults) { course in
                    SearchCellCourseView(course: course, username: username)
                }
            }.searchable(text: $searchText)
        }.onAppear {
            store.dispatch(.api(.getStudent(.get)))
        }
    }
    
    var searchResults: [CourseM] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { $0.code.contains(searchText) }
        }
    }
}

struct SearchCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCourseListView(username: "Jcombariza")
    }
}
