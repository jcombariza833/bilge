//
//  StudentView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI
import Firebase
import Combine

struct StudentView: View {
    @EnvironmentObject var store: AppStore
        
    var body: some View {
        StudentTapView().onAppear {
            store.dispatch(.api(.getInstructors(.get)))
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
