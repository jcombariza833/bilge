//
//  GLink.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/11/21.
//

import SwiftUI

struct GLink: View {
    var labelText: String
    var activeColor: Color? = nil
    var inactiveColor: Color? = nil
    var action: (() -> ())
    
    @GestureState private var isPress = false
    
    var body: some View {
        Text(labelText)
            .bold()
            .font(.system(size: 14))
            .textCase(.uppercase)
            .foregroundColor(isPress ? activeColor ?? Color("noFocus") : inactiveColor ?? Color("noFocus") )
            .gesture(
                LongPressGesture(minimumDuration: 0.05)
                    .updating($isPress, body: { value, state, transition in
                        state = value
                    })
                    .onEnded({ _ in
                        action()
                    })
            )
    }
}

struct GLink_Previews: PreviewProvider {
    static var previews: some View {
        GLink(labelText: "Link", activeColor: .blue) {
            
        }
    }
}
