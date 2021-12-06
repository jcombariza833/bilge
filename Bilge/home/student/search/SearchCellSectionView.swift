//
//  SearchCellSectionView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchCellSectionView: View {
    @EnvironmentObject var store: AppStore
    @State var studentsEnrolled = 0
    
    var username: String
    var course: CourseM
    var section: SectionM
    
    var enrollingInProgress: Bool {
        get {
            store.state.api.enrrolInProgress
        }
    }
    
    var enrolled: [EnrolledSectionM] {
        get {
            store.state.api.student?.enrolled ?? [EnrolledSectionM]()
        }
    }
    
    var isEnrroled: Bool {
        get {
            let sectionE = enrolled.first { erolledSection in
                erolledSection.section.code == section.code
            }
            
            return sectionE != nil
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.code)
                    .font(.title2)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Students enrolled  \(studentsEnrolled)/\(section.maxStudents)")
                    .font(.caption)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
        
            Spacer()
            if isEnrroled {
                Text("Enrolled").foregroundColor(.gray.opacity(0.5)).padding()
            } else {
                if enrollingInProgress {
                    ProgressView().padding()
                } else {
                    GButton(labelText: "enroll", color: .blue, fullWidth: nil) {
                        store.dispatch(.api(.enrollClass(.enroll(username, course.code, section.code))))
                        if section.maxStudents > studentsEnrolled {
                            studentsEnrolled += 1
                        }
                        
                    }
                }

            }
        }
    }
}

struct SearchCellSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellSectionView(username: "Jcombariza", course: CourseM(), section: SectionM())
    }
}
