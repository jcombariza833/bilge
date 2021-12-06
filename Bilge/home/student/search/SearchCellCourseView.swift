//
//  SearchCellCourseView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchCellCourseView: View {
    var course: CourseM
    var username: String
    
    var body: some View {
        NavigationLink {
            SearchSectionsListView(username: username, course: course, sections: course.sections)
                .navigationTitle("Sections")
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(course.name)
                    .font(.title2)
                    .fixedSize(horizontal: false, vertical: true)
                Text(course.code)
                    .font(.caption)
                Text(course.description)
                    .font(.caption)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
        }
    }
}

struct SearchCellCourseView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellCourseView(course: CourseM(), username: "Jcombariza")
    }
}
