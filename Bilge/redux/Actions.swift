//
//  Actions.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/1/21.
//

import Foundation
import Combine
import SwiftUI
import Firebase


enum AppAction {
    case session(SessionAction)
    case login(SignInAction)
    case registration(SignUpAction)
    case resetPassword(ForgotPasswordAction)
    case updatePassword(UpdatePasswordAction)
    case api(ApiAction)
}

enum SessionAction {
    typealias Token = String
    typealias errorMessage = String?
    
    case token(User?)
    case tokenUpdated(Token)
    case tokenError(errorMessage)
    
    case signOut
    case signOutSuccess
    case signOutError(errorMessage)
}

enum UpdatePasswordAction {
    typealias Password = String
    typealias payload = (Password)
    typealias errorMessage = String?
    
    case fetch(payload)
    case fetchSuccess
    case fetchError(errorMessage)
}

enum ApiAction {
    case updateRole(UpdateRoleAction)
    case updateProfile(UpdateProfileAction)
    case getInstructor(InstructorAction)
    case getStudent(StudentAction)
    case createCourse(CreateCourseAction)
    case deleteCourse(DeleteCourseAction)
    case createSection(CreateSectionAction)
    case deleteSection(DeleteSectionAction)
    case getInstructors(InstructorsAction)
    case getInstructorByName(InstructorByNameAction)
    case enrollClass(EnrollAction)
    case unenrollClass(UnenrollAction)
}

enum UpdateRoleAction {
    typealias Role = RoleType
    typealias Message = RoleType
    typealias errorMessage = String?
    
    case update(Role)
    case success(String)
    case error(errorMessage)
}

enum UpdateProfileAction {
    typealias Message = RoleType
    typealias errorMessage = String?
    
    case update(ProfileInput)
    case success(String)
    case error(errorMessage)
}

enum InstructorAction {
    typealias Instructor = InstructorM
    typealias errorMessage = String?
    
    case get
    case success(Instructor)
    case error(errorMessage)
}

enum StudentAction {
    typealias Student = StudentM
    typealias errorMessage = String?
    
    case get
    case success(Student)
    case error(errorMessage)
}

enum CreateCourseAction {
    typealias errorMessage = String?
    
    case create(CourseInput)
    case success(String)
    case error(errorMessage)
}

enum DeleteCourseAction {
    typealias CourseCode = String
    typealias errorMessage = String?
    
    case delete(CourseCode)
    case success(String)
    case error(errorMessage)
    
    case internalDelete(IndexSet)
}

enum CreateSectionAction {
    typealias CourseCode = String
    typealias errorMessage = String?
    
    case create(SectionInput, CourseCode)
    case success(String)
    case error(errorMessage)
    
    
}

enum DeleteSectionAction {
    typealias CourseCode = String
    typealias SectionCode = String
    typealias errorMessage = String?
    
    case delete(CourseCode, SectionCode)
    case success(String)
    case error(errorMessage)
    
    case internalDelete(IndexSet, CourseCode)
}

enum InstructorsAction {
    typealias Instructors = [InstructorM]
    typealias errorMessage = String?
    
    case get
    case success(Instructors)
    case error(errorMessage)
}

enum InstructorByNameAction {
    typealias Instructor = InstructorM
    typealias Username = String
    typealias errorMessage = String?
    
    case get(Username)
    case success(Instructor)
    case error(errorMessage)
}

enum EnrollAction {
    typealias Username = String
    typealias CourseCode = String
    typealias SectionCode = String
    typealias errorMessage = String?
    
    case enroll(Username, CourseCode, SectionCode)
    case success(String)
    case error(errorMessage)
}

enum UnenrollAction {
    typealias SectionCode = String
    typealias errorMessage = String?
    
    case unenroll(SectionCode)
    case success(String)
    case error(errorMessage)
}
