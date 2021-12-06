//
//  APIState.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/13/21.
//

import Foundation

struct APIState {
    typealias Instructor = InstructorQuery.Data.Instructor
    typealias Student = StudentQuery.Data.Student
    
    var fetchInProgress = false
    var fetchError: String?
    
    //MARK: - instructors
    var instructors: [InstructorM]?
    //MARK: - selectedInstructor
    var selectedInstructor: InstructorM?
    
    //MARK: - instructor
    var instructor: InstructorM?
    
    //MARK: - student
    var student: StudentM?
    
    //MARK: - create course
    var createCourseInProgress = false
    var createCourseError: String?
    
    //MARK: - create course
    var createSectionInProgress = false
    var createSectionError: String?
    
    //MARK: - enroll section
    var enrrolInProgress = false
    var enrollError: String?
    //MARK: - unenroll section
    var unenrrolInProgress = false
    var unenrollError: String?
    
    
    var updateProfile: APIUpdateProfileState
}

struct APIUpdateProfileState {
    var fetchInProgress = false
    var fetchError: String?
}
