//
//  StudentTapView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/13/21.
//

import SwiftUI

struct StudentTapView: View {
    @EnvironmentObject var store: AppStore
    
    enum StudentTypeTap: Int {
        case profile, search, grades
    }
    
    @State var currentTap: StudentTypeTap = .search
    
    var body: some View {
        TabView(selection: $currentTap) {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(StudentTypeTap.profile)

            SearchCourseView()
                .tabItem {
                    Label("Enroll", systemImage: "magnifyingglass")
                }
                .tag(StudentTypeTap.search)
            EnrolledCourseListView()
                .tabItem {
                    Label("Courses", systemImage: "book")
                }
                .tag(StudentTypeTap.grades)
            
        }
    }
}

struct StudentTapView_Previews: PreviewProvider {
    static var previews: some View {
        StudentTapView()
    }
}
