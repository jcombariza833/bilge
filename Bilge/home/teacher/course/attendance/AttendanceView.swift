//
//  AttendanceView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import SwiftUI
import MultipeerConnectivity

struct AttendanceView: View {
    @EnvironmentObject var pollManager: PollManger
    @EnvironmentObject var pollConnection: PollConnectionManager
    var body: some View {
        List {
            ForEach(pollConnection.studentsAvailable, id: \.self) { student in
                Text(student.displayName)
            }
        }
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}
