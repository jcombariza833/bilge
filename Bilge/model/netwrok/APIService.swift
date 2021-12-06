//
//  APIService.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/12/21.
//

import Foundation
import Combine

enum GraphQLError: Error {
    case graphqlError(String)
    case networkError(String)
}

protocol APIService {
    // MARK: - queries
    func instructors() -> AnyPublisher<[InstructorM], GraphQLError>
    func students(sectionCode: String) -> AnyPublisher<String, GraphQLError>
    func instructor() -> AnyPublisher<InstructorM, GraphQLError>
    func student() -> AnyPublisher<StudentM, GraphQLError>
    func instructorBy(username: String) -> AnyPublisher<InstructorM, GraphQLError>
    
    // MARK: - mutations
    func updateRole(role: RoleType) -> AnyPublisher<String, GraphQLError>
    func updateProfile(profile: ProfileInput) -> AnyPublisher<String, GraphQLError>
    func createCourse(course: CourseInput) -> AnyPublisher<String, GraphQLError>
    func deleteCourse(courseCode: String) -> AnyPublisher<String, GraphQLError>
    func addSection(section: SectionInput, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func deleteSection(sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func addSyllabus(file: String, sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func deleteSyllabus(file: String, sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func addFiles(files: [String], sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func deleteFiles(files: [String], sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func enroll(instructorUsername: String, sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError>
    func unenroll(sectionCode: String) -> AnyPublisher<String, GraphQLError>
    
}

// MARK: - Models

struct NameM: Codable {
    var fName: String
    var lName: String
    
    init() {
        fName = ""
        lName = ""
    }

    init(instructor: InstructorQuery.Data.Instructor) {
        fName = instructor.name?.fName ?? ""
        lName = instructor.name?.lName ?? ""
    }
    
    init(instructors: InstructorsQuery.Data.Instructor) {
        fName = instructors.name?.fName ?? ""
        lName = instructors.name?.lName ?? ""
    }

    init(student: StudentQuery.Data.Student) {
        fName = student.name?.fName ?? ""
        lName = student.name?.lName ?? ""
    }
    
    init(instructorEnrolled: StudentQuery.Data.Student.Enrolled.Instructor) {
        fName = instructorEnrolled.name?.fName ?? ""
        lName = instructorEnrolled.name?.lName ?? ""
    }
    
    init(selectedInstructor: InstructorByQuery.Data.InstructorBy) {
        fName = selectedInstructor.name?.fName ?? ""
        lName = selectedInstructor.name?.lName ?? ""
    }
}

struct EnrolledSectionM: Codable, Identifiable {
    var id = UUID()
    
    var instructor: InstructorM
    var course: CourseM
    var section: SectionM

    init() {
        instructor = InstructorM()
        course = CourseM()
        section = SectionM()
    }
    
    init(enrolled: StudentQuery.Data.Student.Enrolled) {
        instructor = InstructorM(instructorEnrolled: enrolled.instructor)
        course = CourseM(courseEnrolled: enrolled.course)
        section = SectionM(sectionEnrolled: enrolled.section)
    }
}

struct StudentM: Codable, Identifiable {
    var id = UUID()
    
    var username: String
    var email: String
    var role: RoleType
    var name: NameM

    var enrolled: [EnrolledSectionM]

    init() {
        name = NameM()
        username =  ""
        email = ""
        role = .student
        enrolled = [EnrolledSectionM]()
    }
    
    init(student: StudentQuery.Data.Student) {
        name = NameM(student: student)
        username = student.username ?? ""
        email = student.email
        role = RoleType.fromApi(role: student.role ?? .student)
        let enrroledSections = student.enrolled?.compactMap {$0}
        enrolled = enrroledSections?.map {EnrolledSectionM(enrolled:$0)} ?? [EnrolledSectionM]()
    }
}

struct InstructorM: Codable, Identifiable {
    var id = UUID()
    
    var username: String
    var email: String
    var role: RoleType
    var name: NameM

    var courses: [CourseM]

    init() {
        name = NameM()
        username = ""
        email = ""
        role = .student
        courses = [CourseM]()
    }
    
    init(instructor: InstructorQuery.Data.Instructor) {
        name = NameM(instructor: instructor)
        username = instructor.username ?? ""
        email = instructor.email
        role = RoleType.fromApi(role: instructor.role ?? .student)
        let coursesOptional = instructor.courses?.compactMap {$0}
        courses = coursesOptional?.map {CourseM(course:$0)} ?? [CourseM]()
    }
    
    init(instructors: InstructorsQuery.Data.Instructor) {
        name = NameM(instructors: instructors)
        username = instructors.username ?? ""
        email = instructors.email
        role = RoleType.fromApi(role: instructors.role ?? .student)
        courses = [CourseM]()
    }
    
    init(instructorEnrolled: StudentQuery.Data.Student.Enrolled.Instructor) {
        name = NameM(instructorEnrolled: instructorEnrolled)
        username = instructorEnrolled.username ?? ""
        email = instructorEnrolled.email
        role = RoleType.fromApi(role: instructorEnrolled.role ?? .instructor)
        courses = [CourseM]()
    }
    
    init(selectedInstructor: InstructorByQuery.Data.InstructorBy) {
        name = NameM(selectedInstructor: selectedInstructor)
        username = selectedInstructor.username ?? ""
        email = selectedInstructor.email
        role = RoleType.fromApi(role: selectedInstructor.role ?? .student)
        let coursesOptional = selectedInstructor.courses?.compactMap {$0}
        courses = coursesOptional?.map {CourseM(courseBy:$0)} ?? [CourseM]()
    }
}

struct CourseM: Codable, Identifiable {
    var id = UUID()
    
    var name: String
    var description: String
    var code: String
    var sections: [SectionM]
    
    init() {
        name = ""
        description = ""
        code = ""
        sections = [SectionM]()
    }
    
    init(courseEnrolled: StudentQuery.Data.Student.Enrolled.Course) {
        name = courseEnrolled.name
        description = courseEnrolled.description
        code = courseEnrolled.code
        sections = [SectionM]()
    }
    
    init(course: InstructorQuery.Data.Instructor.Course) {
        name = course.name
        description = course.description
        code = course.code
        let sectionsOptional = course.sections?.compactMap {$0}
        sections = sectionsOptional?.map {SectionM(section:$0)} ?? [SectionM]()
    }
    
    init(courseBy: InstructorByQuery.Data.InstructorBy.Course) {
        name = courseBy.name
        description = courseBy.description
        code = courseBy.code
        let sectionsOptional = courseBy.sections?.compactMap {$0}
        sections = sectionsOptional?.map {SectionM(sectionBy:$0)} ?? [SectionM]()
    }
}

struct SectionM: Codable, Identifiable {
    var id = UUID()
    
    var isActive: Bool
    var code: String
    var schedule: [ScheduleM]
    var maxStudents: Int
    var syllabus: String
    
    init() {
        isActive = false
        code = ""
        schedule = [ScheduleM]()
        maxStudents = 0
        syllabus = ""
    }
    
    init(sectionEnrolled: StudentQuery.Data.Student.Enrolled.Section) {
        isActive = sectionEnrolled.isActive
        code = sectionEnrolled.code
        let enrroledSchedules = sectionEnrolled.schedule.compactMap {$0}
        schedule = enrroledSchedules.map {ScheduleM(enrolledSchedule:$0)}
        maxStudents = sectionEnrolled.maxStudents
        syllabus = sectionEnrolled.syllabus ?? ""
    }
    
    init(section: InstructorQuery.Data.Instructor.Course.Section) {
        isActive = section.isActive
        code = section.code
        let enrroledSchedules = section.schedule.compactMap {$0}
        schedule = enrroledSchedules.map {ScheduleM(schedule:$0)}
        maxStudents = section.maxStudents
        syllabus = section.syllabus ?? ""
    }
    
    init(sectionBy: InstructorByQuery.Data.InstructorBy.Course.Section) {
        isActive = sectionBy.isActive
        code = sectionBy.code
        let enrroledSchedules = sectionBy.schedule.compactMap {$0}
        schedule = enrroledSchedules.map {ScheduleM(scheduleBy:$0)}
        maxStudents = sectionBy.maxStudents
        syllabus = sectionBy.syllabus ?? ""
    }
}


struct ScheduleM: Codable {
    var day: String
    var isActive: Bool
    var classroom: String
    
    init(){
        day = ""
        isActive = false
        classroom = ""
    }
    
    init(enrolledSchedule: StudentQuery.Data.Student.Enrolled.Section.Schedule){
        day = enrolledSchedule.day
        isActive = enrolledSchedule.isActive
        classroom = enrolledSchedule.classroom
    }
    
    init(schedule: InstructorQuery.Data.Instructor.Course.Section.Schedule){
        day = schedule.day
        isActive = schedule.isActive
        classroom = schedule.classroom
    }
    
    init(scheduleBy: InstructorByQuery.Data.InstructorBy.Course.Section.Schedule){
        day = scheduleBy.day
        isActive = scheduleBy.isActive
        classroom = scheduleBy.classroom
    }
}
