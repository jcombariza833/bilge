//
//  EnrolledCourseListViewModel.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import Foundation
import Combine

class EnrolledCourseListViewModel: ObservableObject {
    @Published var store: AppStore?
    @Published var enrolledClasses = [EnrolledSectionM]()
    
    var enrolledClassesCaller: [EnrolledSectionM] {
        get {
            store?.state.api.student?.enrolled ?? [EnrolledSectionM]()
        }
    }
}
