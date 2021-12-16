//
//  SessionState.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/4/21.
//

import Foundation
import Firebase

enum RoleType: Codable {
    case insturctor
    case student
    case admin
    
    func toApi() -> Role {
        switch self {
        case .insturctor:
            return Role.instructor
        case .student:
            return Role.student
        case .admin:
            return Role.admin
        }
    }
    
    static func fromApi(role: Role) -> RoleType {
        switch role {
        case .student:
            return RoleType.student
        case .instructor:
            return RoleType.insturctor
        case .admin:
            return RoleType.admin
        case .__unknown(_):
            return RoleType.student
        }
    }
}

struct SessionState {
    // MARK: - onboarding
    var singUp: SignUpState
    var singIn: SignInState
    var uid = ""
    var role = RoleType.insturctor
    var token = ""
}
