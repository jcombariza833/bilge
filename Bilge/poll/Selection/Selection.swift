//
//  Selection.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import Foundation
struct Selection: PollComponent {
    var type: PollComponentType = .selection
    var question: String
    var time: Int
    
    var options: [String]
}

struct SelectionFeedBack: FeedBack {
    static  var type: PollComponentType = .selection
    var vote: [String: Bool]
}
