//
//  EnrolledCourseListViewModel.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import Foundation
import Combine

class EnrolledCourseListViewModel: ObservableObject {
    @Published var store: AppStore?
    @Published var enrolledClasses = [EnrolledSectionM]()
    
    var enrolledClassesCaller: [EnrolledSectionM] {
        get {
            store?.state.api.student?.enrolled ?? [EnrolledSectionM]()
        }
    }
    
    //MARK: -
    @Published var instructor = InstructorM()
    @Published var section = SectionM()
    @Published var course = CourseM()
    @Published var pdfData : Data?
    @Published var isReceivingPolls = false
    @Published var pollList = [PollModel]()
    
    var username: String {
        get {
            store?.state.api.student?.username ?? ""
        }
    }
     
    var instrunctorName: String {
        get {
            "\(instructor.name.fName) \(instructor.name.lName)"
        }
    }
    
    var email: String {
        get {
            instructor.email
        }
    }
    
    var courseName: String {
        get {
            course.name
        }
    }
    
    var week: [ScheduleData] {
        get {
            section.schedule.map({ scheduleM in
                ScheduleData(day: scheduleM.day, classroom: scheduleM.classroom, isActive: scheduleM.isActive)
            })
        }
    }
    
    var roomCode: String {
        get {
            "\(course.code) - \(section.code)"
        }
    }
    
    var service: String {
        get {
            roomCode.lowercased().trimmingCharacters(in: .illegalCharacters).replacingOccurrences(of: " ", with: "")
        }
    }
}
