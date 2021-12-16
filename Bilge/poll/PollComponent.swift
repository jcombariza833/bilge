//
//  Pool.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/28/21.
//

import Foundation
import SwiftUI
import RealmSwift

enum PollComponentType: String, CaseIterable, Codable {
    case statement
    case multipleChoice
    case selection
    case agree
    
    func toString() -> String  {
        switch self {
        case .statement:
            return "Statement"
        case .multipleChoice:
            return "Multiple Choice"
        case .selection:
            return "Selection"
        case .agree:
            return "Agreement"
        }
    }
    
    func icon() -> String {
        switch self {
        case .statement:
            return "rectangle.grid.1x2"
        case .multipleChoice:
            return "circle.grid.2x1.left.filled"
        case .selection:
            return "checklist"
        case .agree:
            return "slider.horizontal.below.rectangle"
        }
    }
    
    func view() -> AnyView {
        switch self {
        case .statement:
            return AnyView(StatementFormView())
        case .multipleChoice:
            return AnyView(MultipleChoiceFormView())
        case .selection:
            return AnyView(SelectionFormView())
        case .agree:
            return AnyView(AgreeFormView())
        }
    }
}

protocol PollComponent: Codable {
    var type: PollComponentType { get }
    var question: String { get }
    var time: Int { get }
}


protocol FeedBack: Codable {
    static var type: PollComponentType { get }
}


struct Poll {
    var name: String
    var components: [PollComponent]
    var courseCode: String
    var sectionCode: String
}
