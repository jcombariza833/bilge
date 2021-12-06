//
//  GToggleStyle.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/16/21.
//

import Foundation
import SwiftUI

struct GToggleStyle: ToggleStyle {
    var colorOn: Color? = nil
    var iconOn: String? = nil
    var colorOff: Color? = nil
    var iconOff: String? = nil
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? colorOn ?? .green : colorOff ?? Color("noFocus"))
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? iconOn ?? "checkmark" : iconOff ?? "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundColor(configuration.isOn ? colorOn ?? .green : colorOff ?? Color("noFocus"))
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(.linear(duration: 0.1), value: configuration.isOn)
                        
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
}
