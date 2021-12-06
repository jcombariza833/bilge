//
//  SecurityView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/21/21.
//

import SwiftUI

struct SecurityView: View {
    var body: some View {
        List {
            Section("Security") {
                NavigationLink {
                    UpdatePasswordView()
                } label: {
                    Text("Update password")
                }
            }
        }
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
