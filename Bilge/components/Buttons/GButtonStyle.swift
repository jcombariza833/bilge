//
//  GButtonStyle.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/10/21.
//

import Foundation
import SwiftUI

struct GButtonStyle: ButtonStyle {
    var color: Color? = nil
    func makeBody(configuration: Self.Configuration) -> some View {

        configuration.label
            .frame(height: 36, alignment: .center)
            .padding(.horizontal, 16)
            .background(color ?? Color("noFocus"))
            .cornerRadius(5)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
    }
}
