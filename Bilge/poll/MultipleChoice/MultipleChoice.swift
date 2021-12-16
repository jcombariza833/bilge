//
//  MultipleChoice.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import Foundation

struct MultipleChoice: PollComponent {
    
    var type: PollComponentType = .multipleChoice
    var question: String
    var time: Int
    
    var options: [String]
}


struct MultipleChoiceFeedBack: FeedBack {
    static var type: PollComponentType = .multipleChoice
    var vote: [[String: Bool]]
}
