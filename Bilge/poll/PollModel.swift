//
//  PollModel.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/1/21.
//

import Foundation
import RealmSwift

enum PollComponentTypeModel: String, PersistableEnum, Codable {
    case statement
    case multipleChoice
    case selection
    case agree
}

class PollModel: Object, Identifiable, Codable {
    //@Persisted(primaryKey: true) var _id: ObjectId
    var id = UUID()
    @Persisted var name = ""
    @Persisted var courseCode = ""
    @Persisted var sectionCode = ""
    @Persisted var components: List<ComponentModel>
    
    enum CodingKeys: String, CodingKey {
        case name
        case courseCode
        case sectionCode
        case components
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        courseCode = try values.decode(String.self, forKey: .courseCode)
        sectionCode = try values.decode(String.self, forKey: .sectionCode)
        let componentsElements = try values.decode([ComponentModel].self, forKey: .components)
        var componetModels = [ComponentModel]()
        componetModels.append(contentsOf: componentsElements)
        components.append(objectsIn: componetModels)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(courseCode, forKey: .courseCode)
        try container.encode(sectionCode, forKey: .sectionCode)
        let componentArray = Array(self.components)
        try container.encode(componentArray, forKey: .components)
    }
}

class ComponentModel: Object, Codable {
    //@Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var type = PollComponentTypeModel.statement
    @Persisted var option1: String?
    @Persisted var option2: String?
    @Persisted var question = ""
    @Persisted var time: Int = 0
    @Persisted var options: List<OptionModel>
    
    enum CodingKeys: String, CodingKey {
        case type
        case option1
        case option2
        case question
        case time
        case options
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(PollComponentTypeModel.self, forKey: .type)
        option1 = try? values.decode(String.self, forKey: .option1)
        option2 = try? values.decode(String.self, forKey: .option2)
        question = try values.decode(String.self, forKey: .question)
        time = try values.decode(Int.self, forKey: .time)
        let optionsElements = try values.decode([OptionModel].self, forKey: .options)
        var optionsModels = [OptionModel]()
        optionsModels.append(contentsOf: optionsElements)
        options.append(objectsIn: optionsModels)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(option1, forKey: .option1)
        try container.encode(option2, forKey: .option2)
        try container.encode(question, forKey: .question)
        try container.encode(time, forKey: .time)
        let optionsArray = Array(self.options)
        try container.encode(optionsArray, forKey: .options)
    }
}

class OptionModel: Object, Codable {
    //@Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var option = ""
    
    enum CodingKeys: String, CodingKey {
        case option
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        option = try values.decode(String.self, forKey: .option)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(option, forKey: .option)
    }
}
