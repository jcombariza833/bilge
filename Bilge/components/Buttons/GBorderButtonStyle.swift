//
//  GBorderButtonStyle.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/10/21.
//

import Foundation
import SwiftUI

struct GBorderButtonStyle: ButtonStyle {
    var color: Color? = nil
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 36, alignment: .center)
            .padding(.horizontal, 16)
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .overlay(
                RoundedRectangle(cornerRadius:5)
                    .strokeBorder(color ?? Color("noFocus"),
                                  lineWidth: configuration.isPressed ? 2.0 : 1.0)
            )
            
    }
}
