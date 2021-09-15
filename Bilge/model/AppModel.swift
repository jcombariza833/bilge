//
//  AppModel.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import Foundation
import Combine

class AppModel: ObservableObject {
    var remoteReposotory = ""
    var localRespository = ""
    
    @ Published var isLoggedIn = false
}
