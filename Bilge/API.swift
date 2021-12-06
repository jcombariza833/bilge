// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum Role: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case student
  case instructor
  case admin
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "STUDENT": self = .student
      case "INSTRUCTOR": self = .instructor
      case "ADMIN": self = .admin
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .student: return "STUDENT"
      case .instructor: return "INSTRUCTOR"
      case .admin: return "ADMIN"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Role, rhs: Role) -> Bool {
    switch (lhs, rhs) {
      case (.student, .student): return true
      case (.instructor, .instructor): return true
      case (.admin, .admin): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Role] {
    return [
      .student,
      .instructor,
      .admin,
    ]
  }
}

public struct ProfileInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - username
  ///   - name
  public init(username: Swift.Optional<String?> = nil, name: Swift.Optional<NameInput?> = nil) {
    graphQLMap = ["username": username, "name": name]
  }

  public var username: Swift.Optional<String?> {
    get {
      return graphQLMap["username"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "username")
    }
  }

  public var name: Swift.Optional<NameInput?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<NameInput?> ?? Swift.Optional<NameInput?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }
}

public struct NameInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - fName
  ///   - lName
  public init(fName: Swift.Optional<String?> = nil, lName: Swift.Optional<String?> = nil) {
    graphQLMap = ["fName": fName, "lName": lName]
  }

  public var fName: Swift.Optional<String?> {
    get {
      return graphQLMap["fName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fName")
    }
  }

  public var lName: Swift.Optional<String?> {
    get {
      return graphQLMap["lName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lName")
    }
  }
}

public struct CourseInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - name
  ///   - description
  ///   - code
  public init(name: String, description: String, code: String) {
    graphQLMap = ["name": name, "description": description, "code": code]
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var description: String {
    get {
      return graphQLMap["description"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var code: String {
    get {
      return graphQLMap["code"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "code")
    }
  }
}

public struct SectionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - isActive
  ///   - code
  ///   - schedule
  ///   - maxStudents
  public init(isActive: Bool, code: String, schedule: [ScheduleInput?], maxStudents: Int) {
    graphQLMap = ["isActive": isActive, "code": code, "schedule": schedule, "maxStudents": maxStudents]
  }

  public var isActive: Bool {
    get {
      return graphQLMap["isActive"] as! Bool
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isActive")
    }
  }

  public var code: String {
    get {
      return graphQLMap["code"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "code")
    }
  }

  public var schedule: [ScheduleInput?] {
    get {
      return graphQLMap["schedule"] as! [ScheduleInput?]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "schedule")
    }
  }

  public var maxStudents: Int {
    get {
      return graphQLMap["maxStudents"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "maxStudents")
    }
  }
}

public struct ScheduleInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - day
  ///   - isActive
  ///   - classroom
  public init(day: String, isActive: Bool, classroom: String) {
    graphQLMap = ["day": day, "isActive": isActive, "classroom": classroom]
  }

  public var day: String {
    get {
      return graphQLMap["day"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "day")
    }
  }

  public var isActive: Bool {
    get {
      return graphQLMap["isActive"] as! Bool
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isActive")
    }
  }

  public var classroom: String {
    get {
      return graphQLMap["classroom"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "classroom")
    }
  }
}

public final class InstructorsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Instructors {
      instructors {
        __typename
        name {
          __typename
          fName
          lName
        }
        username
        email
        role
      }
    }
    """

  public let operationName: String = "Instructors"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("instructors", type: .list(.object(Instructor.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(instructors: [Instructor?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "instructors": instructors.flatMap { (value: [Instructor?]) -> [ResultMap?] in value.map { (value: Instructor?) -> ResultMap? in value.flatMap { (value: Instructor) -> ResultMap in value.resultMap } } }])
    }

    public var instructors: [Instructor?]? {
      get {
        return (resultMap["instructors"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Instructor?] in value.map { (value: ResultMap?) -> Instructor? in value.flatMap { (value: ResultMap) -> Instructor in Instructor(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Instructor?]) -> [ResultMap?] in value.map { (value: Instructor?) -> ResultMap? in value.flatMap { (value: Instructor) -> ResultMap in value.resultMap } } }, forKey: "instructors")
      }
    }

    public struct Instructor: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Instructor"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .object(Name.selections)),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("role", type: .scalar(Role.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: Name? = nil, username: String? = nil, email: String, role: Role? = nil) {
        self.init(unsafeResultMap: ["__typename": "Instructor", "name": name.flatMap { (value: Name) -> ResultMap in value.resultMap }, "username": username, "email": email, "role": role])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: Name? {
        get {
          return (resultMap["name"] as? ResultMap).flatMap { Name(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "name")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var role: Role? {
        get {
          return resultMap["role"] as? Role
        }
        set {
          resultMap.updateValue(newValue, forKey: "role")
        }
      }

      public struct Name: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Name"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lName", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fName: String, lName: String) {
          self.init(unsafeResultMap: ["__typename": "Name", "fName": fName, "lName": lName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fName: String {
          get {
            return resultMap["fName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fName")
          }
        }

        public var lName: String {
          get {
            return resultMap["lName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lName")
          }
        }
      }
    }
  }
}

public final class InstructorByQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query InstructorBy($username: String!) {
      instructorBy(username: $username) {
        __typename
        name {
          __typename
          fName
          lName
        }
        username
        email
        isEmailVerified
        creationDate
        role
        courses {
          __typename
          name
          description
          code
          sections {
            __typename
            isActive
            code
            schedule {
              __typename
              day
              isActive
              classroom
            }
            maxStudents
            syllabus
          }
        }
      }
    }
    """

  public let operationName: String = "InstructorBy"

  public var username: String

  public init(username: String) {
    self.username = username
  }

  public var variables: GraphQLMap? {
    return ["username": username]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("instructorBy", arguments: ["username": GraphQLVariable("username")], type: .object(InstructorBy.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(instructorBy: InstructorBy? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "instructorBy": instructorBy.flatMap { (value: InstructorBy) -> ResultMap in value.resultMap }])
    }

    public var instructorBy: InstructorBy? {
      get {
        return (resultMap["instructorBy"] as? ResultMap).flatMap { InstructorBy(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "instructorBy")
      }
    }

    public struct InstructorBy: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Instructor"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .object(Name.selections)),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("isEmailVerified", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("creationDate", type: .nonNull(.scalar(Double.self))),
          GraphQLField("role", type: .scalar(Role.self)),
          GraphQLField("courses", type: .list(.nonNull(.object(Course.selections)))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: Name? = nil, username: String? = nil, email: String, isEmailVerified: Bool, creationDate: Double, role: Role? = nil, courses: [Course]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Instructor", "name": name.flatMap { (value: Name) -> ResultMap in value.resultMap }, "username": username, "email": email, "isEmailVerified": isEmailVerified, "creationDate": creationDate, "role": role, "courses": courses.flatMap { (value: [Course]) -> [ResultMap] in value.map { (value: Course) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: Name? {
        get {
          return (resultMap["name"] as? ResultMap).flatMap { Name(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "name")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var isEmailVerified: Bool {
        get {
          return resultMap["isEmailVerified"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isEmailVerified")
        }
      }

      public var creationDate: Double {
        get {
          return resultMap["creationDate"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "creationDate")
        }
      }

      public var role: Role? {
        get {
          return resultMap["role"] as? Role
        }
        set {
          resultMap.updateValue(newValue, forKey: "role")
        }
      }

      public var courses: [Course]? {
        get {
          return (resultMap["courses"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Course] in value.map { (value: ResultMap) -> Course in Course(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Course]) -> [ResultMap] in value.map { (value: Course) -> ResultMap in value.resultMap } }, forKey: "courses")
        }
      }

      public struct Name: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Name"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lName", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fName: String, lName: String) {
          self.init(unsafeResultMap: ["__typename": "Name", "fName": fName, "lName": lName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fName: String {
          get {
            return resultMap["fName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fName")
          }
        }

        public var lName: String {
          get {
            return resultMap["lName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lName")
          }
        }
      }

      public struct Course: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Course"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(String.self))),
            GraphQLField("sections", type: .list(.nonNull(.object(Section.selections)))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, description: String, code: String, sections: [Section]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Course", "name": name, "description": description, "code": code, "sections": sections.flatMap { (value: [Section]) -> [ResultMap] in value.map { (value: Section) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var code: String {
          get {
            return resultMap["code"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var sections: [Section]? {
          get {
            return (resultMap["sections"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Section] in value.map { (value: ResultMap) -> Section in Section(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Section]) -> [ResultMap] in value.map { (value: Section) -> ResultMap in value.resultMap } }, forKey: "sections")
          }
        }

        public struct Section: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Section"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("isActive", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("schedule", type: .nonNull(.list(.nonNull(.object(Schedule.selections))))),
              GraphQLField("maxStudents", type: .nonNull(.scalar(Int.self))),
              GraphQLField("syllabus", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(isActive: Bool, code: String, schedule: [Schedule], maxStudents: Int, syllabus: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Section", "isActive": isActive, "code": code, "schedule": schedule.map { (value: Schedule) -> ResultMap in value.resultMap }, "maxStudents": maxStudents, "syllabus": syllabus])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var isActive: Bool {
            get {
              return resultMap["isActive"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isActive")
            }
          }

          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
            }
          }

          public var schedule: [Schedule] {
            get {
              return (resultMap["schedule"] as! [ResultMap]).map { (value: ResultMap) -> Schedule in Schedule(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Schedule) -> ResultMap in value.resultMap }, forKey: "schedule")
            }
          }

          public var maxStudents: Int {
            get {
              return resultMap["maxStudents"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxStudents")
            }
          }

          public var syllabus: String? {
            get {
              return resultMap["syllabus"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "syllabus")
            }
          }

          public struct Schedule: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Schedule"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("day", type: .nonNull(.scalar(String.self))),
                GraphQLField("isActive", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("classroom", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(day: String, isActive: Bool, classroom: String) {
              self.init(unsafeResultMap: ["__typename": "Schedule", "day": day, "isActive": isActive, "classroom": classroom])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var day: String {
              get {
                return resultMap["day"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "day")
              }
            }

            public var isActive: Bool {
              get {
                return resultMap["isActive"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isActive")
              }
            }

            public var classroom: String {
              get {
                return resultMap["classroom"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "classroom")
              }
            }
          }
        }
      }
    }
  }
}

public final class InstructorQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Instructor {
      instructor {
        __typename
        name {
          __typename
          fName
          lName
        }
        username
        email
        isEmailVerified
        creationDate
        role
        courses {
          __typename
          name
          description
          code
          sections {
            __typename
            isActive
            code
            schedule {
              __typename
              day
              isActive
              classroom
            }
            maxStudents
            syllabus
            files
          }
        }
      }
    }
    """

  public let operationName: String = "Instructor"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("instructor", type: .object(Instructor.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(instructor: Instructor? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "instructor": instructor.flatMap { (value: Instructor) -> ResultMap in value.resultMap }])
    }

    public var instructor: Instructor? {
      get {
        return (resultMap["instructor"] as? ResultMap).flatMap { Instructor(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "instructor")
      }
    }

    public struct Instructor: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Instructor"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .object(Name.selections)),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("isEmailVerified", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("creationDate", type: .nonNull(.scalar(Double.self))),
          GraphQLField("role", type: .scalar(Role.self)),
          GraphQLField("courses", type: .list(.nonNull(.object(Course.selections)))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: Name? = nil, username: String? = nil, email: String, isEmailVerified: Bool, creationDate: Double, role: Role? = nil, courses: [Course]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Instructor", "name": name.flatMap { (value: Name) -> ResultMap in value.resultMap }, "username": username, "email": email, "isEmailVerified": isEmailVerified, "creationDate": creationDate, "role": role, "courses": courses.flatMap { (value: [Course]) -> [ResultMap] in value.map { (value: Course) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: Name? {
        get {
          return (resultMap["name"] as? ResultMap).flatMap { Name(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "name")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var isEmailVerified: Bool {
        get {
          return resultMap["isEmailVerified"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isEmailVerified")
        }
      }

      public var creationDate: Double {
        get {
          return resultMap["creationDate"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "creationDate")
        }
      }

      public var role: Role? {
        get {
          return resultMap["role"] as? Role
        }
        set {
          resultMap.updateValue(newValue, forKey: "role")
        }
      }

      public var courses: [Course]? {
        get {
          return (resultMap["courses"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Course] in value.map { (value: ResultMap) -> Course in Course(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Course]) -> [ResultMap] in value.map { (value: Course) -> ResultMap in value.resultMap } }, forKey: "courses")
        }
      }

      public struct Name: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Name"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lName", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fName: String, lName: String) {
          self.init(unsafeResultMap: ["__typename": "Name", "fName": fName, "lName": lName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fName: String {
          get {
            return resultMap["fName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fName")
          }
        }

        public var lName: String {
          get {
            return resultMap["lName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lName")
          }
        }
      }

      public struct Course: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Course"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(String.self))),
            GraphQLField("sections", type: .list(.nonNull(.object(Section.selections)))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, description: String, code: String, sections: [Section]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Course", "name": name, "description": description, "code": code, "sections": sections.flatMap { (value: [Section]) -> [ResultMap] in value.map { (value: Section) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var code: String {
          get {
            return resultMap["code"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var sections: [Section]? {
          get {
            return (resultMap["sections"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Section] in value.map { (value: ResultMap) -> Section in Section(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Section]) -> [ResultMap] in value.map { (value: Section) -> ResultMap in value.resultMap } }, forKey: "sections")
          }
        }

        public struct Section: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Section"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("isActive", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("schedule", type: .nonNull(.list(.nonNull(.object(Schedule.selections))))),
              GraphQLField("maxStudents", type: .nonNull(.scalar(Int.self))),
              GraphQLField("syllabus", type: .scalar(String.self)),
              GraphQLField("files", type: .list(.nonNull(.scalar(String.self)))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(isActive: Bool, code: String, schedule: [Schedule], maxStudents: Int, syllabus: String? = nil, files: [String]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Section", "isActive": isActive, "code": code, "schedule": schedule.map { (value: Schedule) -> ResultMap in value.resultMap }, "maxStudents": maxStudents, "syllabus": syllabus, "files": files])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var isActive: Bool {
            get {
              return resultMap["isActive"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isActive")
            }
          }

          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
            }
          }

          public var schedule: [Schedule] {
            get {
              return (resultMap["schedule"] as! [ResultMap]).map { (value: ResultMap) -> Schedule in Schedule(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Schedule) -> ResultMap in value.resultMap }, forKey: "schedule")
            }
          }

          public var maxStudents: Int {
            get {
              return resultMap["maxStudents"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxStudents")
            }
          }

          public var syllabus: String? {
            get {
              return resultMap["syllabus"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "syllabus")
            }
          }

          public var files: [String]? {
            get {
              return resultMap["files"] as? [String]
            }
            set {
              resultMap.updateValue(newValue, forKey: "files")
            }
          }

          public struct Schedule: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Schedule"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("day", type: .nonNull(.scalar(String.self))),
                GraphQLField("isActive", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("classroom", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(day: String, isActive: Bool, classroom: String) {
              self.init(unsafeResultMap: ["__typename": "Schedule", "day": day, "isActive": isActive, "classroom": classroom])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var day: String {
              get {
                return resultMap["day"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "day")
              }
            }

            public var isActive: Bool {
              get {
                return resultMap["isActive"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isActive")
              }
            }

            public var classroom: String {
              get {
                return resultMap["classroom"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "classroom")
              }
            }
          }
        }
      }
    }
  }
}

public final class StudentsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Students($sectionCode: String!) {
      students(sectionCode: $sectionCode) {
        __typename
        name {
          __typename
          fName
          lName
        }
        username
        email
        role
      }
    }
    """

  public let operationName: String = "Students"

  public var sectionCode: String

  public init(sectionCode: String) {
    self.sectionCode = sectionCode
  }

  public var variables: GraphQLMap? {
    return ["sectionCode": sectionCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("students", arguments: ["sectionCode": GraphQLVariable("sectionCode")], type: .list(.object(Student.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(students: [Student?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "students": students.flatMap { (value: [Student?]) -> [ResultMap?] in value.map { (value: Student?) -> ResultMap? in value.flatMap { (value: Student) -> ResultMap in value.resultMap } } }])
    }

    public var students: [Student?]? {
      get {
        return (resultMap["students"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Student?] in value.map { (value: ResultMap?) -> Student? in value.flatMap { (value: ResultMap) -> Student in Student(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Student?]) -> [ResultMap?] in value.map { (value: Student?) -> ResultMap? in value.flatMap { (value: Student) -> ResultMap in value.resultMap } } }, forKey: "students")
      }
    }

    public struct Student: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Student"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .object(Name.selections)),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("role", type: .scalar(Role.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: Name? = nil, username: String? = nil, email: String, role: Role? = nil) {
        self.init(unsafeResultMap: ["__typename": "Student", "name": name.flatMap { (value: Name) -> ResultMap in value.resultMap }, "username": username, "email": email, "role": role])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: Name? {
        get {
          return (resultMap["name"] as? ResultMap).flatMap { Name(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "name")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var role: Role? {
        get {
          return resultMap["role"] as? Role
        }
        set {
          resultMap.updateValue(newValue, forKey: "role")
        }
      }

      public struct Name: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Name"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lName", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fName: String, lName: String) {
          self.init(unsafeResultMap: ["__typename": "Name", "fName": fName, "lName": lName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fName: String {
          get {
            return resultMap["fName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fName")
          }
        }

        public var lName: String {
          get {
            return resultMap["lName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lName")
          }
        }
      }
    }
  }
}

public final class StudentQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Student {
      student {
        __typename
        name {
          __typename
          fName
          lName
        }
        username
        email
        isEmailVerified
        creationDate
        role
        enrolled {
          __typename
          instructor {
            __typename
            name {
              __typename
              fName
              lName
            }
            username
            email
            role
          }
          course {
            __typename
            name
            description
            code
          }
          section {
            __typename
            isActive
            code
            schedule {
              __typename
              day
              isActive
              classroom
            }
            maxStudents
            syllabus
            files
          }
        }
      }
    }
    """

  public let operationName: String = "Student"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("student", type: .object(Student.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(student: Student? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "student": student.flatMap { (value: Student) -> ResultMap in value.resultMap }])
    }

    public var student: Student? {
      get {
        return (resultMap["student"] as? ResultMap).flatMap { Student(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "student")
      }
    }

    public struct Student: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Student"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .object(Name.selections)),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("isEmailVerified", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("creationDate", type: .nonNull(.scalar(Double.self))),
          GraphQLField("role", type: .scalar(Role.self)),
          GraphQLField("enrolled", type: .list(.nonNull(.object(Enrolled.selections)))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: Name? = nil, username: String? = nil, email: String, isEmailVerified: Bool, creationDate: Double, role: Role? = nil, enrolled: [Enrolled]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Student", "name": name.flatMap { (value: Name) -> ResultMap in value.resultMap }, "username": username, "email": email, "isEmailVerified": isEmailVerified, "creationDate": creationDate, "role": role, "enrolled": enrolled.flatMap { (value: [Enrolled]) -> [ResultMap] in value.map { (value: Enrolled) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: Name? {
        get {
          return (resultMap["name"] as? ResultMap).flatMap { Name(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "name")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var isEmailVerified: Bool {
        get {
          return resultMap["isEmailVerified"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isEmailVerified")
        }
      }

      public var creationDate: Double {
        get {
          return resultMap["creationDate"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "creationDate")
        }
      }

      public var role: Role? {
        get {
          return resultMap["role"] as? Role
        }
        set {
          resultMap.updateValue(newValue, forKey: "role")
        }
      }

      public var enrolled: [Enrolled]? {
        get {
          return (resultMap["enrolled"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Enrolled] in value.map { (value: ResultMap) -> Enrolled in Enrolled(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Enrolled]) -> [ResultMap] in value.map { (value: Enrolled) -> ResultMap in value.resultMap } }, forKey: "enrolled")
        }
      }

      public struct Name: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Name"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lName", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fName: String, lName: String) {
          self.init(unsafeResultMap: ["__typename": "Name", "fName": fName, "lName": lName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fName: String {
          get {
            return resultMap["fName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fName")
          }
        }

        public var lName: String {
          get {
            return resultMap["lName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lName")
          }
        }
      }

      public struct Enrolled: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EnrolledSection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("instructor", type: .nonNull(.object(Instructor.selections))),
            GraphQLField("course", type: .nonNull(.object(Course.selections))),
            GraphQLField("section", type: .nonNull(.object(Section.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(instructor: Instructor, course: Course, section: Section) {
          self.init(unsafeResultMap: ["__typename": "EnrolledSection", "instructor": instructor.resultMap, "course": course.resultMap, "section": section.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var instructor: Instructor {
          get {
            return Instructor(unsafeResultMap: resultMap["instructor"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "instructor")
          }
        }

        public var course: Course {
          get {
            return Course(unsafeResultMap: resultMap["course"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "course")
          }
        }

        public var section: Section {
          get {
            return Section(unsafeResultMap: resultMap["section"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "section")
          }
        }

        public struct Instructor: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Instructor"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .object(Name.selections)),
              GraphQLField("username", type: .scalar(String.self)),
              GraphQLField("email", type: .nonNull(.scalar(String.self))),
              GraphQLField("role", type: .scalar(Role.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: Name? = nil, username: String? = nil, email: String, role: Role? = nil) {
            self.init(unsafeResultMap: ["__typename": "Instructor", "name": name.flatMap { (value: Name) -> ResultMap in value.resultMap }, "username": username, "email": email, "role": role])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: Name? {
            get {
              return (resultMap["name"] as? ResultMap).flatMap { Name(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "name")
            }
          }

          public var username: String? {
            get {
              return resultMap["username"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "username")
            }
          }

          public var email: String {
            get {
              return resultMap["email"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "email")
            }
          }

          public var role: Role? {
            get {
              return resultMap["role"] as? Role
            }
            set {
              resultMap.updateValue(newValue, forKey: "role")
            }
          }

          public struct Name: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Name"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("fName", type: .nonNull(.scalar(String.self))),
                GraphQLField("lName", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(fName: String, lName: String) {
              self.init(unsafeResultMap: ["__typename": "Name", "fName": fName, "lName": lName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fName: String {
              get {
                return resultMap["fName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "fName")
              }
            }

            public var lName: String {
              get {
                return resultMap["lName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "lName")
              }
            }
          }
        }

        public struct Course: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Course"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("description", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, description: String, code: String) {
            self.init(unsafeResultMap: ["__typename": "Course", "name": name, "description": description, "code": code])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var description: String {
            get {
              return resultMap["description"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
            }
          }
        }

        public struct Section: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Section"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("isActive", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("schedule", type: .nonNull(.list(.nonNull(.object(Schedule.selections))))),
              GraphQLField("maxStudents", type: .nonNull(.scalar(Int.self))),
              GraphQLField("syllabus", type: .scalar(String.self)),
              GraphQLField("files", type: .list(.nonNull(.scalar(String.self)))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(isActive: Bool, code: String, schedule: [Schedule], maxStudents: Int, syllabus: String? = nil, files: [String]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Section", "isActive": isActive, "code": code, "schedule": schedule.map { (value: Schedule) -> ResultMap in value.resultMap }, "maxStudents": maxStudents, "syllabus": syllabus, "files": files])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var isActive: Bool {
            get {
              return resultMap["isActive"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isActive")
            }
          }

          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
            }
          }

          public var schedule: [Schedule] {
            get {
              return (resultMap["schedule"] as! [ResultMap]).map { (value: ResultMap) -> Schedule in Schedule(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Schedule) -> ResultMap in value.resultMap }, forKey: "schedule")
            }
          }

          public var maxStudents: Int {
            get {
              return resultMap["maxStudents"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxStudents")
            }
          }

          public var syllabus: String? {
            get {
              return resultMap["syllabus"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "syllabus")
            }
          }

          public var files: [String]? {
            get {
              return resultMap["files"] as? [String]
            }
            set {
              resultMap.updateValue(newValue, forKey: "files")
            }
          }

          public struct Schedule: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Schedule"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("day", type: .nonNull(.scalar(String.self))),
                GraphQLField("isActive", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("classroom", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(day: String, isActive: Bool, classroom: String) {
              self.init(unsafeResultMap: ["__typename": "Schedule", "day": day, "isActive": isActive, "classroom": classroom])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var day: String {
              get {
                return resultMap["day"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "day")
              }
            }

            public var isActive: Bool {
              get {
                return resultMap["isActive"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isActive")
              }
            }

            public var classroom: String {
              get {
                return resultMap["classroom"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "classroom")
              }
            }
          }
        }
      }
    }
  }
}

public final class UpdateRoleMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateRole($role: Role!) {
      updateRole(role: $role)
    }
    """

  public let operationName: String = "UpdateRole"

  public var role: Role

  public init(role: Role) {
    self.role = role
  }

  public var variables: GraphQLMap? {
    return ["role": role]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateRole", arguments: ["role": GraphQLVariable("role")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateRole: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateRole": updateRole])
    }

    public var updateRole: String? {
      get {
        return resultMap["updateRole"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "updateRole")
      }
    }
  }
}

public final class UpdateProfileMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateProfile($profile: ProfileInput!) {
      updateProfile(profile: $profile)
    }
    """

  public let operationName: String = "UpdateProfile"

  public var profile: ProfileInput

  public init(profile: ProfileInput) {
    self.profile = profile
  }

  public var variables: GraphQLMap? {
    return ["profile": profile]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateProfile", arguments: ["profile": GraphQLVariable("profile")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateProfile: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateProfile": updateProfile])
    }

    public var updateProfile: String? {
      get {
        return resultMap["updateProfile"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "updateProfile")
      }
    }
  }
}

public final class CreateCourseMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateCourse($course: CourseInput!) {
      createCourse(course: $course)
    }
    """

  public let operationName: String = "CreateCourse"

  public var course: CourseInput

  public init(course: CourseInput) {
    self.course = course
  }

  public var variables: GraphQLMap? {
    return ["course": course]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createCourse", arguments: ["course": GraphQLVariable("course")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createCourse: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createCourse": createCourse])
    }

    public var createCourse: String? {
      get {
        return resultMap["createCourse"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "createCourse")
      }
    }
  }
}

public final class DeleteCourseMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteCourse($courseCode: String!) {
      deleteCourse(courseCode: $courseCode)
    }
    """

  public let operationName: String = "DeleteCourse"

  public var courseCode: String

  public init(courseCode: String) {
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteCourse", arguments: ["courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteCourse: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteCourse": deleteCourse])
    }

    public var deleteCourse: String? {
      get {
        return resultMap["deleteCourse"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteCourse")
      }
    }
  }
}

public final class AddSectionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddSection($section: SectionInput!, $courseCode: String!) {
      addSection(section: $section, courseCode: $courseCode)
    }
    """

  public let operationName: String = "AddSection"

  public var section: SectionInput
  public var courseCode: String

  public init(section: SectionInput, courseCode: String) {
    self.section = section
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["section": section, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addSection", arguments: ["section": GraphQLVariable("section"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addSection: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addSection": addSection])
    }

    public var addSection: String? {
      get {
        return resultMap["addSection"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "addSection")
      }
    }
  }
}

public final class DeleteSectionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteSection($sectionCode: String!, $courseCode: String!) {
      deleteSection(sectionCode: $sectionCode, courseCode: $courseCode)
    }
    """

  public let operationName: String = "DeleteSection"

  public var sectionCode: String
  public var courseCode: String

  public init(sectionCode: String, courseCode: String) {
    self.sectionCode = sectionCode
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["sectionCode": sectionCode, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteSection", arguments: ["sectionCode": GraphQLVariable("sectionCode"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteSection: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteSection": deleteSection])
    }

    public var deleteSection: String? {
      get {
        return resultMap["deleteSection"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteSection")
      }
    }
  }
}

public final class AddSyllabusMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddSyllabus($file: String!, $sectionCode: String!, $courseCode: String!) {
      addSyllabus(file: $file, sectionCode: $sectionCode, courseCode: $courseCode)
    }
    """

  public let operationName: String = "AddSyllabus"

  public var file: String
  public var sectionCode: String
  public var courseCode: String

  public init(file: String, sectionCode: String, courseCode: String) {
    self.file = file
    self.sectionCode = sectionCode
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["file": file, "sectionCode": sectionCode, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addSyllabus", arguments: ["file": GraphQLVariable("file"), "sectionCode": GraphQLVariable("sectionCode"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addSyllabus: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addSyllabus": addSyllabus])
    }

    public var addSyllabus: String? {
      get {
        return resultMap["addSyllabus"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "addSyllabus")
      }
    }
  }
}

public final class DeleteSyllabusMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteSyllabus($sectionCode: String!, $courseCode: String!) {
      deleteSyllabus(sectionCode: $sectionCode, courseCode: $courseCode)
    }
    """

  public let operationName: String = "DeleteSyllabus"

  public var sectionCode: String
  public var courseCode: String

  public init(sectionCode: String, courseCode: String) {
    self.sectionCode = sectionCode
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["sectionCode": sectionCode, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteSyllabus", arguments: ["sectionCode": GraphQLVariable("sectionCode"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteSyllabus: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteSyllabus": deleteSyllabus])
    }

    public var deleteSyllabus: String? {
      get {
        return resultMap["deleteSyllabus"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteSyllabus")
      }
    }
  }
}

public final class AddFilesMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddFiles($files: [String]!, $sectionCode: String!, $courseCode: String!) {
      addFiles(files: $files, sectionCode: $sectionCode, courseCode: $courseCode)
    }
    """

  public let operationName: String = "AddFiles"

  public var files: [String?]
  public var sectionCode: String
  public var courseCode: String

  public init(files: [String?], sectionCode: String, courseCode: String) {
    self.files = files
    self.sectionCode = sectionCode
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["files": files, "sectionCode": sectionCode, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addFiles", arguments: ["files": GraphQLVariable("files"), "sectionCode": GraphQLVariable("sectionCode"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addFiles: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addFiles": addFiles])
    }

    public var addFiles: String? {
      get {
        return resultMap["addFiles"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "addFiles")
      }
    }
  }
}

public final class DeleteFilesMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteFiles($files: [String]!, $sectionCode: String!, $courseCode: String!) {
      deleteFiles(files: $files, sectionCode: $sectionCode, courseCode: $courseCode)
    }
    """

  public let operationName: String = "DeleteFiles"

  public var files: [String?]
  public var sectionCode: String
  public var courseCode: String

  public init(files: [String?], sectionCode: String, courseCode: String) {
    self.files = files
    self.sectionCode = sectionCode
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["files": files, "sectionCode": sectionCode, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("deleteFiles", arguments: ["files": GraphQLVariable("files"), "sectionCode": GraphQLVariable("sectionCode"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteFiles: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteFiles": deleteFiles])
    }

    public var deleteFiles: String? {
      get {
        return resultMap["deleteFiles"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteFiles")
      }
    }
  }
}

public final class EnrollMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Enroll($instructorUsername: String!, $sectionCode: String!, $courseCode: String!) {
      enroll(
        instructorUsername: $instructorUsername
        sectionCode: $sectionCode
        courseCode: $courseCode
      )
    }
    """

  public let operationName: String = "Enroll"

  public var instructorUsername: String
  public var sectionCode: String
  public var courseCode: String

  public init(instructorUsername: String, sectionCode: String, courseCode: String) {
    self.instructorUsername = instructorUsername
    self.sectionCode = sectionCode
    self.courseCode = courseCode
  }

  public var variables: GraphQLMap? {
    return ["instructorUsername": instructorUsername, "sectionCode": sectionCode, "courseCode": courseCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("enroll", arguments: ["instructorUsername": GraphQLVariable("instructorUsername"), "sectionCode": GraphQLVariable("sectionCode"), "courseCode": GraphQLVariable("courseCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(enroll: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "enroll": enroll])
    }

    public var enroll: String? {
      get {
        return resultMap["enroll"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "enroll")
      }
    }
  }
}

public final class UnenrollMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Unenroll($sectionCode: String!) {
      unenroll(sectionCode: $sectionCode)
    }
    """

  public let operationName: String = "Unenroll"

  public var sectionCode: String

  public init(sectionCode: String) {
    self.sectionCode = sectionCode
  }

  public var variables: GraphQLMap? {
    return ["sectionCode": sectionCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("unenroll", arguments: ["sectionCode": GraphQLVariable("sectionCode")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(unenroll: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "unenroll": unenroll])
    }

    public var unenroll: String? {
      get {
        return resultMap["unenroll"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "unenroll")
      }
    }
  }
}
