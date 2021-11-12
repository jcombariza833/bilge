//
//  UserData.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/6/21.
//

import Foundation

protocol UserData: Codable {
    var name: Name { get set }
    var username: String { get set }
    var email: String { get set }
    var isEmailVerified: Bool { get set }
    var creationDate: Date { get set }
}

struct Name: Codable {
    var fName: String
    var lName: String
}

struct Student: UserData, Codable {
    var name: Name
    var username: String
    var email: String
    var isEmailVerified: Bool
    var creationDate: Date
}

struct Instructor: UserData, Codable {
    var name: Name
    var username: String
    var email: String
    var isEmailVerified: Bool
    var creationDate: Date
}

struct Course: Codable {
    var name: String
    var description: String
    var code: String
    var creator: Instructor
    var sections: [Section]
}

struct Section: Codable {
    var isActive: Bool
    var instructor: Instructor
    var code: String
    var classrooms: [String]
    var tasks: [Task]
    var files: [String]
    
    private enum CodingKeys : CodingKey {
        case isActive, instructor, code, classrooms, tasks, files
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.instructor = try container.decode(Instructor.self, forKey: .instructor)
        self.code = try container.decode(String.self, forKey: .code)
        self.classrooms = try container.decode([String].self, forKey: .classrooms)
        self.tasks = try container.decode([AnyTask].self, forKey: .tasks).map { $0.base }
        self.files = try container.decode([String].self, forKey: .files)
    }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(isActive, forKey: .isActive)
            try container.encode(instructor, forKey: .instructor)
            try container.encode(code, forKey: .code)
            try container.encode(classrooms, forKey: .classrooms)
            try container.encode(tasks.map(AnyTask.init), forKey: .tasks)
            try container.encode(files, forKey: .files)
            
        }
}

protocol Task: Codable {
    static var type: TaskType { get }
    
    var name: String { get set }
    var maxScore: Int { get set }
    var isHidden: Bool { get set }
}

enum TaskType: String, Codable {
    case quiz, exam, assignment
    
    var metatype: Task.Type {
        switch self {
        case .quiz:
            return Quizz.self
        case .exam:
            return Exam.self
        case .assignment:
            return Assignment.self
        }
    }
}
    
struct Exam: Task {
    static let type = TaskType.exam
    
    var name: String
    var maxScore: Int
    var isHidden: Bool
    
    var questions: [Question]?
    var file: String?
}
    
struct Quizz: Task {
    static let type = TaskType.quiz
    
    var name: String
    var maxScore: Int
    var isHidden: Bool
    
    var questions: [Question]
}
    
struct Assignment: Task {
    static let type = TaskType.assignment
    
    var name: String
    var maxScore: Int
    var isHidden: Bool
    
    var file: String
}

struct AnyTask: Codable {
    
    var base: Task

    init(_ base: Task) {
        self.base = base
    }
    
    private enum CodingKeys : CodingKey {
        case type, base
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let type = try container.decode(TaskType.self, forKey: .type)
            self.base = try type.metatype.init(from: decoder)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(type(of: base).type, forKey: .type)
            try base.encode(to: encoder)
        }
}


struct Question: Codable {
    var description: String
    var answers: [Answer]
}

struct Answer: Codable {
    var description: String
    var isCorrect: Bool
}
