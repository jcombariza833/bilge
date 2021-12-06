//
//  Agree.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import Foundation
struct Agree: PollComponent {
    var type: PollComponentType = .agree
    var question: String
    var time: Int
}


struct AgreeFeedBack: FeedBack {
    static var type: PollComponentType = .agree
    var vote: Int
}
