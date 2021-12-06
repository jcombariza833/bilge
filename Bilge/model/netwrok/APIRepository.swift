//
//  APIRepository.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/12/21.
//

import Foundation
import Combine
import Apollo

final class APIRepository: APIService {
    
    private static func url() -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 5001
        components.path = "/bilge-85236/us-central1/graphql"

        return components.url!
    }

    private(set) lazy var apollo: ApolloClient = {
            let client = URLSessionClient()
            let cache = InMemoryNormalizedCache()
            let store = ApolloStore(cache: cache)
            let provider = NetworkInterceptorProvider(client: client, store: store)
            let url = APIRepository.url()
            let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                         endpointURL: url)
            return ApolloClient(networkTransport: transport, store: store)
        }()
    
    
    
    func updateRole(role: RoleType) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: UpdateRoleMutation(role: role.toApi())) { result in
                switch result {
                case .success(let graphQLResult):
                    if let response = graphQLResult.data?.updateRole {
                            return promise(.success(response))
                        } else if let errors = graphQLResult.errors {
                            let message = errors.first?.message ?? ""
                            return promise(.failure(.graphqlError(message)))
                        }
                case .failure(_):
                    return promise(.failure(.networkError("Network error")))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func instructors() -> AnyPublisher<[InstructorM], GraphQLError> {
        return Future<[InstructorM], GraphQLError> { promise in
            self.apollo.fetch(query: InstructorsQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
                if let instructors = try? result.get().data?.instructors {
                    let optionalInstructors = instructors.compactMap { $0 }
                    let fixedInstructors = optionalInstructors.map { InstructorM(instructors: $0) }
                    return promise(.success(fixedInstructors))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func students(sectionCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            if true {
                promise(.success("userId"))
            } else {
                promise(.failure(.graphqlError("")))
            }
        }.eraseToAnyPublisher()
    }
    
    func instructor() -> AnyPublisher<InstructorM, GraphQLError> {
        return Future<InstructorM, GraphQLError> { promise in
            self.apollo.fetch(query: InstructorQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
                if let instructor = try? result.get().data?.instructor {
                    let fixedInstructor = InstructorM(instructor: instructor)
                    return promise(.success(fixedInstructor))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func student() -> AnyPublisher<StudentM, GraphQLError> {
        return Future<StudentM, GraphQLError> { promise in
            self.apollo.fetch(query: StudentQuery(),cachePolicy: .fetchIgnoringCacheData){ result in
                if let student = try? result.get().data?.student {
                    let fixedStudent = StudentM(student: student)
                    return promise(.success(fixedStudent))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateProfile(profile: ProfileInput) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: UpdateProfileMutation(profile: profile)) { result in
                if let response = try? result.get().data?.updateProfile {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func createCourse(course: CourseInput) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: CreateCourseMutation(course: course)) { result in
                if let response = try? result.get().data?.createCourse {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteCourse(courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: DeleteCourseMutation(courseCode: courseCode)) { result in
                if let response = try? result.get().data?.deleteCourse {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func addSection(section: SectionInput, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: AddSectionMutation(section: section, courseCode: courseCode)) { result in
                if let response = try? result.get().data?.addSection {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteSection(sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: DeleteSectionMutation(sectionCode: sectionCode, courseCode: courseCode)) { result in
                if let response = try? result.get().data?.deleteSection {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func addSyllabus(file: String, sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            if true {
                promise(.success("userId"))
            } else {
                promise(.failure(.graphqlError("")))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteSyllabus(file: String, sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            if true {
                promise(.success("userId"))
            } else {
                promise(.failure(.graphqlError("")))
            }
        }.eraseToAnyPublisher()
    }
    
    func addFiles(files: [String], sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            if true {
                promise(.success("userId"))
            } else {
                promise(.failure(.graphqlError("")))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteFiles(files: [String], sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            if true {
                promise(.success("userId"))
            } else {
                promise(.failure(.graphqlError("")))
            }
        }.eraseToAnyPublisher()
    }
    
    func instructorBy(username: String) -> AnyPublisher<InstructorM, GraphQLError> {
        return Future<InstructorM, GraphQLError> { promise in
            self.apollo.fetch(query: InstructorByQuery(username: username), cachePolicy: .fetchIgnoringCacheData) { result in
                if let instructor = try? result.get().data?.instructorBy {
                    let fixedInstructor = InstructorM(selectedInstructor: instructor)
                    return promise(.success(fixedInstructor))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func enroll(instructorUsername: String, sectionCode: String, courseCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: EnrollMutation(instructorUsername: instructorUsername, sectionCode: sectionCode, courseCode: courseCode)) { result in
                if let response = try? result.get().data?.enroll {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
    
    func unenroll(sectionCode: String) -> AnyPublisher<String, GraphQLError> {
        return Future<String, GraphQLError> { promise in
            self.apollo.perform(mutation: UnenrollMutation(sectionCode: sectionCode)) { result in
                if let response = try? result.get().data?.unenroll {
                    return promise(.success(response))
                }
                
                if let errors = try? result.get().errors, let message = errors[0].message {
                    return promise(.failure(.graphqlError(message)))
                }
                
                return promise(.failure(.graphqlError("No connection with the server")))
            }
        }.eraseToAnyPublisher()
    }
}
