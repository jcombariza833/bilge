//
//  View+Extension.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/16/21.
//

import Foundation
import SwiftUI

extension View {
    func snackBarPopUp(isPresented: Binding<Bool>,
                       labelText: String,
                       leadingIcon: String? = nil,
                       textColor: Color? = nil,
                       color: Color? = nil,
                       buttonText: String? = nil,
                       buttonColor: Color? = nil,
                       action: (() -> ())? = nil) -> some View {
        
        self.modifier(SnackBarPopUp(isPresented: isPresented,
                                    labelText: labelText,
                                    leadingIcon: leadingIcon,
                                    textColor: textColor,
                                    color: color,
                                    buttonText: buttonText,
                                    buttonColor: buttonColor,
                                    action: action))
    }
}

class Dissmiser {
    var work: DispatchWorkItem?
}
