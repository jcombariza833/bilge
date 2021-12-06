//
//  SearchCellUsernameView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchCellUsernameView: View {
    @EnvironmentObject var store: AppStore
    var username: String
    
    var body: some View {
        NavigationLink {
            SearchCourseListView(username: username)
                .navigationTitle("Courses")
                .onAppear {
                    store.dispatch(.api(.getInstructorByName(.get(username))))
                }
        } label: {
            Text(username).font(.headline).padding()
        }
    }
}

struct SearchCellUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellUsernameView(username: "jcombariza")
    }
}
