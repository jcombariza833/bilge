//
//  PersistenceController.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/1/21.
//

import Foundation
import RealmSwift

class PersistenceController {
    static let shared = PersistenceController()
    private var database:Realm
    
    private init() {
        database = try! Realm()
    }

    func add(poll: PollModel)   {
        try! database.write {
            database.add(poll)
        }
    }
    
    func getAllPolls() -> [PollModel] {
        database.objects(PollModel.self).map { $0 }
    }
    
    func getAllPolls(courseCode: String, sectioCode: String) -> [PollModel] {
        let allPolls = database.objects(PollModel.self)
        let allPollByCourse = allPolls.where {
            $0.courseCode == courseCode
        }
        let allPollBySection = allPollByCourse.where {
            $0.sectionCode == sectioCode
        }
        
        return allPollBySection.map { $0 }
    }
    
    func deletePoll(poll: PollModel) {
        try! database.write {
            database.delete(poll)
        }
    }
}

protocol Mapper {
    associatedtype A
    associatedtype B
    static func convert(_ a: A) -> B
    static func invert(_ b: B) -> A
}
