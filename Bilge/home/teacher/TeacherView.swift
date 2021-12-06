//
//  TeacherView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI
import Firebase
import Combine

struct TeacherView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        TeacherTapView()
    }
}

struct TeacherView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherView()
    }
}
