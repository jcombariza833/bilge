//
//  CoursesContentView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/13/21.
//

import SwiftUI

struct CoursesContentView: View {
    
    @EnvironmentObject var store: AppStore
    @State var isAddingCourses = false
    
    var courses: [CourseM] {
        get { store.state.api.instructor?.courses ?? [CourseM]() }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(courses) { course in
                    NavigationLink {
                        SectionListView(course:course)
                    } label: {
                        CourseCellView(course: course)
                    }
                }.onDelete(perform: delete)
                
                HStack {
                    Spacer()
                    addButton
                    Spacer()
                }.padding()
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            self.isAddingCourses.toggle()
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.body)
                    .padding(.all, 4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("New Course")
                    .font(.body)
                    .foregroundColor(.blue)
            }
        }.sheet(isPresented: self.$isAddingCourses) {
            CreateCourseView()
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { (i) in
            let course = courses[i]
            store.dispatch(.api(.deleteCourse(.delete(course.code))))
        }
        store.dispatch(.api(.deleteCourse(.internalDelete(offsets))))
    }
}

struct CoursesContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesContentView()
    }
}
