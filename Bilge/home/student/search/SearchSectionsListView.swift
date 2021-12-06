//
//  SearchSectionsListView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchSectionsListView: View {

    @State private var searchText = ""
    
    var username: String
    var course: CourseM
    var sections: [SectionM]
    
    var body: some View {
        VStack {
            List {
                ForEach(sections) { section in
                    SearchCellSectionView(username: username, course: course, section: section)
                }
            }.searchable(text: $searchText)
        }
    }
    
    var searchResults: [SectionM] {
        if searchText.isEmpty {
            return sections
        } else {
            return sections.filter { $0.code.contains(searchText) }
        }
    }
}

struct SearchSectionsListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSectionsListView(username: "Jcombariza", course: CourseM(), sections: [SectionM]())
    }
}
