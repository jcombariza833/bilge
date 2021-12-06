//
//  APIMiddleware.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/1/21.
//

import Foundation
import Firebase
import Combine
import Apollo

func apiMiddleware(_ apiRepository: APIRepository) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
            //MARK: - updateRole
        case .api(.updateRole(.update(let role))):
            guard !state.session.token.isEmpty else {
                return Just(.api(.updateRole(.error("invalid token")))).eraseToAnyPublisher()
            }
            
            if UserDefaults.standard.bool(forKey: "role") {
                return Just(.api(.updateRole(.error("role already set")))).eraseToAnyPublisher()
            }
            
            return apiRepository.updateRole(role: role).subscribe(on: DispatchQueue.main)
                .map {
                    UserDefaults.standard.set(true, forKey: "role")
                    return .api(.updateRole(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.updateRole(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.updateRole(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - apiRepository
        case .api(.updateProfile(.update(let profile))):
            return apiRepository.updateProfile(profile: profile).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.updateProfile(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.updateProfile(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.updateProfile(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - getInstructor
        case .api(.getInstructor(.get)):
            return apiRepository.instructor().subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.getInstructor(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.getInstructor(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.getInstructor(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - getStudent
        case .api(.getStudent(.get)):
            return apiRepository.student().subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.getStudent(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.getStudent(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.getStudent(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - createCourse
        case .api(.createCourse(.create(let course))):
            return apiRepository.createCourse(course: course).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.createCourse(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.createCourse(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.createCourse(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - deleteCourse
        case .api(.deleteCourse(.delete(let courseCode))):
            return apiRepository.deleteCourse(courseCode: courseCode).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.deleteCourse(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.deleteCourse(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.deleteCourse(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - createSection
        case .api(.createSection(.create(let section, let courseCode))):
            return apiRepository.addSection(section: section, courseCode: courseCode).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.createSection(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.createSection(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.createSection(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - deleteCourse
        case .api(.deleteSection(.delete(let courseCode, let sectionCode))):
            return apiRepository.deleteSection(sectionCode: sectionCode, courseCode: courseCode).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.deleteCourse(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.deleteCourse(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.deleteCourse(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - getInstructors
        case .api(.getInstructors(.get)):
            return apiRepository.instructors().subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.getInstructors(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.getInstructors(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.getInstructors(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - getInstructorByUsername
        case .api(.getInstructorByName(.get(let username))):
            return apiRepository.instructorBy(username: username).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.getInstructorByName(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.getInstructorByName(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.getInstructorByName(.error(message))))
                    }
                }.eraseToAnyPublisher()
            
            //MARK: - enrollClass
        case .api(.enrollClass(.enroll(let username, let courseCode, let sectionCode))):
            return apiRepository.enroll(instructorUsername: username, sectionCode: sectionCode, courseCode: courseCode).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.enrollClass(.success($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.enrollClass(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.enrollClass(.error(message))))
                    }
                }.eraseToAnyPublisher()
            //MARK: - enrollClass
        case .api(.unenrollClass(.unenroll(let sectionCode))):
            return apiRepository.unenroll(sectionCode: sectionCode).subscribe(on: DispatchQueue.main)
                .map {
                    return .api(.unenrollClass(.unenroll($0)))
                }
                .catch { (error: GraphQLError) -> Just<AppAction> in
                    switch error {
                    case .graphqlError(let message):
                        return Just(.api(.unenrollClass(.error(message))))
                    case .networkError(let message):
                        return Just(.api(.unenrollClass(.error(message))))
                    }
                }.eraseToAnyPublisher()
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
