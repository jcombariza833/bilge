//
//  SectionListView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/4/21.
//

import SwiftUI

struct SectionListView: View {
    @EnvironmentObject var store: AppStore
    @State var isAddingSection = false
    
    var sections: [SectionM] {
        get { course.sections }
    }
    
    var course: CourseM
    
    var body: some View {
        VStack {
            List {
                ForEach(sections) { section in
                    NavigationLink {
                        ClassView(course: course, section: section)
                    } label: {
                        Text(section.code)
                    }
                }.onDelete(perform: delete)
                
                HStack {
                    Spacer()
                    addButton
                    Spacer()
                }.padding()
            }
        }.navigationTitle("Sections")
    }
    
    var addButton: some View {
        Button(action: {
            self.isAddingSection.toggle()
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.body)
                    .padding(.all, 4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("New Section")
                    .font(.body)
                    .foregroundColor(.blue)
            }
        }.sheet(isPresented: self.$isAddingSection) {
            CreateSectionView(course: course)
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { (i) in
            let section = sections[i]
            store.dispatch(.api(.deleteSection(.delete(course.code, section.code))))
        }
        store.dispatch(.api(.deleteSection(.internalDelete(offsets, course.code))))
    }
}

struct SectionListView_Previews: PreviewProvider {
    static var previews: some View {
        SectionListView(course: CourseM())
    }
}
