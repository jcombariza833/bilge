//
//  Statement.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import Foundation

struct Statement: PollComponent {
    var type: PollComponentType = .statement
    let question: String
    let option1: String
    let option2: String
    var time: Int
}

struct StatementFeedBack: FeedBack {
    static var type: PollComponentType = .statement
    var vote: String
}
