//
//  Account.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import Foundation

struct AccountState {
    var isStudent = UserDefaults.standard.bool(forKey: "isStudent")
    var username = ""
}
