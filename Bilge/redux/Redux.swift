//
//  Redux.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/2/21.
//

import Foundation
import Combine
import SwiftUI

typealias Reducer<State, Action> = (inout State, Action) -> Void
typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>
typealias Listener<State, Action> = (State) -> AnyPublisher<Action, Never>
