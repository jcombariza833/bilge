//
//  ScheculeData.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/4/21.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    
    @Published var schedules = [ScheduleData(day: "Su", classroom: "", isActive: false),
                                 ScheduleData(day: "Mo", classroom: "", isActive: false),
                                 ScheduleData(day: "Tu", classroom: "", isActive: false),
                                 ScheduleData(day: "We", classroom: "", isActive: false),
                                 ScheduleData(day: "Th", classroom: "", isActive: false),
                                 ScheduleData(day: "Fr", classroom: "", isActive: false),
                                 ScheduleData(day: "Sa", classroom: "", isActive: false)]
    
    @Published var schedule = "Su"
    @Published var classroom = ""
    
    var activeSchedules: [ScheduleData] {
        get {
            schedules.filter { $0.isActive == true }
        }
    }
    
    var day: String {
        get {
            week[schedule] ?? ""
        }
    }
    
   private let week = ["Su": "Sunday",
                       "Mo": "Monday",
                       "Tu": "Tuesday",
                       "We": "Wednesday",
                       "Th": "Thursday",
                       "Fr": "Friday",
                       "Sa": "Saturday"]
}

class ScheduleData: Identifiable, Hashable {
    var id: String { day }
    
    var day: String
    var classroom: String
    var isActive: Bool
    
    init(day: String, classroom: String, isActive: Bool) {
        self.day = day
        self.classroom = classroom
        self.isActive = isActive
    }
    
    static func == (lhs: ScheduleData, rhs: ScheduleData) -> Bool {
        return lhs.id == rhs.id && lhs.day == rhs.day && lhs.classroom == rhs.classroom && lhs.isActive == rhs.isActive
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(day)
        hasher.combine(classroom)
        hasher.combine(isActive)
    }
}




