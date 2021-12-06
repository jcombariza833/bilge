//
//  StudentClassView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import SwiftUI

struct StudentClassView: View {
    @EnvironmentObject var store: AppStore
    @ObservedObject var viewModel: EnrolledCourseListViewModel
    @State var showClassroom = false
    
    var enrolled: EnrolledSectionM
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StudentClassView_Previews: PreviewProvider {
    static var previews: some View {
        StudentClassView(viewModel: EnrolledCourseListViewModel(), enrolled: EnrolledSectionM())
    }
}
