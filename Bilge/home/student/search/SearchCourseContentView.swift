//
//  SearchCourseContentVIew.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchCourseContentView: View {
    @EnvironmentObject var store: AppStore
    
    @State private var searchText = ""
    @State var enrollingInProgress = false
    
    var body: some View {
        VStack {
            List {
                ForEach(searchResults) { instructor in
                    SearchCellUsernameView(username: instructor.username)
                }
            }.searchable(text: $searchText)
            
        }
    }
    
    var searchResults: [InstructorM] {
        if searchText.isEmpty {
            return store.state.api.instructors ?? [InstructorM]()
        } else {
            return store.state.api.instructors?.filter { $0.username.contains(searchText) } ?? [InstructorM]()
        }
    }
}

struct SearchCourseContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCourseContentView()
    }
}
