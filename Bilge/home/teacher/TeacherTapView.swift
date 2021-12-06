//
//  TeacherTapView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct TeacherTapView: View {
    @EnvironmentObject var store: AppStore
    
    enum InstructorTypeTap: Int {
        case profile, courses, activitiy
    }
    
    @State var currentTap: InstructorTypeTap = .courses
    
    var body: some View {
        TabView(selection: $currentTap) {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(InstructorTypeTap.profile)
            CoursesView()
                .tabItem {
                    Label("Courses", systemImage: "book")
                }
                .tag(InstructorTypeTap.courses)
            VStack {
                Text("Activity")
                Text("Coming soon")
            }
                .tabItem {
                    Label("Activity", systemImage: "calendar.badge.exclamationmark")
                }
                .tag(InstructorTypeTap.activitiy)
            
        }
    }
}

struct TeacherTapView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherTapView()
    }
}
