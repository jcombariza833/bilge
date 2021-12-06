//
//  GButton.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/9/21.
//

import SwiftUI

struct GButton: View {
    
    var labelText: String
    var leadingIcon: String? = nil
    var textColor: Color? = nil
    var color: Color? = nil
    var fullWidth: Bool? = nil
    var action: (() -> ())

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if let leadingIcon =  leadingIcon {
                    Image(systemName: leadingIcon)
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(textColor ?? Color("noFocus"))
                }
                Text(labelText)
                    .bold()
                    .font(.system(size: 14))
                    .textCase(.uppercase)
                    .foregroundColor(textColor ?? Color.white)
            }.frame(minWidth: 0, maxWidth: fullWidth ?? false ? .infinity : nil)
        }
        .buttonStyle(GButtonStyle(color: color))
    }
}


struct GButton_Previews: PreviewProvider {
    static var previews: some View {
        GButton(labelText: "Action") {
            print("action")
        }
    }
}
