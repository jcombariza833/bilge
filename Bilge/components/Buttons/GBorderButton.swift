//
//  GBorderButton.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/10/21.
//

import SwiftUI

struct GBorderButton: View {
    var labelText: String
    var leadingIcon: String? = nil
    var color: Color? = nil
    var action: (() -> ())
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if let leadingIcon =  leadingIcon {
                    Image(systemName: leadingIcon)
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(color ?? Color("noFocus"))
                }
                Text(labelText)
                    .bold()
                    .font(.system(size: 14))
                    .textCase(.uppercase)
                    .foregroundColor(color ?? Color("noFocus"))
            }
        }
        .buttonStyle(GBorderButtonStyle(color: color))
    }
}

struct GBorderButton_Previews: PreviewProvider {
    static var previews: some View {
        GBorderButton(labelText: "Action") {
            print("action")
        }
    }
}
