//
//  RoomManager.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import Foundation
import SwiftUI
import Combine


class PollManger: ObservableObject, Mapper {
    @Published var counters: [String: Int] = [:]
    @Published var components = [PollComponent]()
    @Published var name = ""
    @Published var polls = [Poll]()
    
    let persitence = PersistenceController.shared
    
    func savePoll(poll: Poll) {
        polls.append(poll)
        storeLocal(poll: poll)
        reset()
    }
    
    func reset() {
        counters = [:]
        components = [PollComponent]()
        name = ""
    }
    
    private func storeLocal(poll: Poll) {
        let pollModel = PollManger.convert(poll)
        persitence.add(poll: pollModel)
    }
    static func convert(_ a: Poll) -> PollModel {
        let pollModel = PollModel()
        pollModel.name = a.name
        pollModel.courseCode = a.courseCode
        pollModel.sectionCode = a.sectionCode
        
        a.components.forEach { component in
            let componentModel = ComponentModel()
            componentModel.question = component.question
            componentModel.time = component.time
            
            switch component.type {
            case .statement:
                let comp = component as! Statement
                componentModel.option1 = comp.option1
                componentModel.option2 = comp.option2
                componentModel.type = PollComponentTypeModel.statement
            case .multipleChoice:
                let comp = component as! MultipleChoice
                comp.options.forEach { option in
                    let optionModel = OptionModel()
                    optionModel.option = option
                    
                    componentModel.options.append(optionModel)
                }
                componentModel.type = PollComponentTypeModel.multipleChoice
            case .selection:
                let comp = component as! Selection
                comp.options.forEach { option in
                    let optionModel = OptionModel()
                    optionModel.option = option
                    
                    componentModel.options.append(optionModel)
                }
                componentModel.type = PollComponentTypeModel.selection
            case .agree:
                componentModel.type = PollComponentTypeModel.agree
            }
            pollModel.components.append(componentModel)
        }
        
        return pollModel
    }
    static func invert(_ b: PollModel) -> Poll {
        
        let components = b.components.map { $0 }
        var mappedComponents = [PollComponent]()
        components.forEach { component in
            switch component.type {
            case .statement:
                mappedComponents.append(Statement(question: component.question,
                                                  option1: component.option1 ?? "",
                                                  option2: component.option2 ?? "",
                                                  time: component.time))
            case .multipleChoice:
                let options = component.options.map { $0 }
                var mappedOptions = [String]()
                options.forEach { option in
                    mappedOptions.append(option.option)
                }
                mappedComponents.append(MultipleChoice(question: component.question,
                                                       time: component.time,
                                                       options: mappedOptions))
            case .selection:
                let options = component.options.map { $0 }
                var mappedOptions = [String]()
                options.forEach { option in
                    mappedOptions.append(option.option)
                }
                mappedComponents.append(Selection(question: component.question,
                                                       time: component.time,
                                                       options: mappedOptions))
            case .agree:
                mappedComponents.append(Agree(question: component.question,
                                                  time: component.time))
            }
        }
        
        return Poll(name: b.name,
                    components: mappedComponents,
                    courseCode: b.courseCode,
                    sectionCode: b.sectionCode)
    }
}
