//
//  CourseCellView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/13/21.
//

import SwiftUI

struct CourseCellView: View {
    var course: CourseM
    
    var body: some View {
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

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCellView(course: CourseM())
    }
}
