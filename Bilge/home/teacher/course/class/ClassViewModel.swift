//
//  ClassViewModel.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/5/21.
//

import Foundation
import Combine

class ClassViewModel: ObservableObject {
    @Published var data : Data?
    
    @Published var store: AppStore?
    @Published var course: CourseM?
    @Published var section: SectionM?
    
    @Published var pollList = [PollModel]()
    
    @Published var startOnline = false
    
    let persistence = PersistenceController.shared
    
    var username: String {
        get {
            "\(store?.state.api.instructor?.username ?? "")"
        }
    }
    
    var name: String {
        get {
            "\(store?.state.api.instructor?.name.fName ?? "") \(store?.state.api.instructor?.name.lName ?? "")"
        }
    }
    
    var email: String {
        get {
            "\(store?.state.api.instructor?.email ?? "")"
        }
    }
    
    var roomCode: String {
        get {
            "\("\(course?.code ?? "") - \(section?.code ?? "")")"
        }
    }
    
    var service: String {
        get {
            roomCode.lowercased().trimmingCharacters(in: .illegalCharacters).replacingOccurrences(of: " ", with: "")
        }
    }
    
    var courseCode: String {
        get {course?.code ?? ""}
    }
    
    var sectionCode: String {
        get {section?.code ?? ""}
    }
    
    var week: [ScheduleData] {
        get {
            section?.schedule.map({ scheduleM in
                ScheduleData(day: scheduleM.day, classroom: scheduleM.classroom, isActive: scheduleM.isActive)
            }) ?? [ScheduleData]()
        }
    }
    
    var pollListCaller: [PollModel] {
        get {
            persistence.getAllPolls(courseCode: courseCode, sectioCode: sectionCode)
        }
        
    }
    
    func deletePoll(poll: PollModel) {
        persistence.deletePoll(poll: poll)
    }
}
