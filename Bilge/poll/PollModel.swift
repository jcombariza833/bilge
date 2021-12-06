//
//  PollModel.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/1/21.
//

import Foundation
import RealmSwift

enum PollComponentTypeModel: String, PersistableEnum {
    case statement
    case multipleChoice
    case selection
    case agree
}

class PollModel: Object, Identifiable {
    //@Persisted(primaryKey: true) var _id: ObjectId
    var id = UUID()
    @Persisted var name = ""
    @Persisted var courseCode = ""
    @Persisted var sectionCode = ""
    @Persisted var components: List<ComponentModel>
}

class ComponentModel: Object {
    //@Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var type = PollComponentTypeModel.statement
    @Persisted var option1: String?
    @Persisted var option2: String?
    @Persisted var question = ""
    @Persisted var time = 0
    @Persisted var options: List<OptionModel>
}

class OptionModel: Object {
    //@Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var option = ""
}
