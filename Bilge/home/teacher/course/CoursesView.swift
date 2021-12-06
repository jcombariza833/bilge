//
//  CursesView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/13/21.
//

import SwiftUI

struct CoursesView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        NavigationView {
            CoursesContentView()
                .navigationTitle("Courses")
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
