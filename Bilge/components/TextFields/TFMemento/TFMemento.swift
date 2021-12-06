//
//  TFMemento.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/21/21.
//

import Foundation

class TFMemento {
    private var state: String
    
    init(state: String) {
        self.state = state
    }
    
    func savedState() -> String {
        state
    }
}

class TFOriginator {
    private var state: String
    
    init(state: String) {
        self.state = state
    }
    
    func setState(_ state: String)  {
        self.state = state
    }
    
    func saveToMemento() -> TFMemento {
        TFMemento(state: state)
    }
    
    func restoreFromMemento(memento: TFMemento) {
        state = memento.savedState()
    }
}

class TFCareTaker {
    private var savedStates = [TFMemento]()
    
    func add(memento: TFMemento) {
        savedStates.append(memento)
    }
    
    func memento(by index: Int) -> TFMemento {
        return savedStates[index]
    }
}
