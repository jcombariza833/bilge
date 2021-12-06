//
//  SearchCourseView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/2/21.
//

import SwiftUI

struct SearchCourseView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        NavigationView {
            SearchCourseContentView()
                .navigationTitle("Users")
        }
    }
}

struct SearchCourseView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCourseView()
    }
}
