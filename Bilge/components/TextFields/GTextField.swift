//
//  GTextField.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 6/30/21.
//

import SwiftUI

struct GTextField: View {
    @Binding var text: String
    var labelText: String
    var leadingIcon: String? = nil
    var trailingIcon: String? = nil
    var helperText: String? = nil
    var trailingIconAction: (() -> ())? = nil
    var color: Color? = nil
    var helperColor: Color? = nil
    
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment:.center) {
            ZStack(alignment:.leading) {
                HStack {
                    if let leadingIcon =  leadingIcon {
                        Image(systemName: leadingIcon)
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color("noFocus"))
                    }
                    
                    ZStack(alignment: .leading ){
                        Text(labelText)
                            .scaleEffect(isEditing ? 0.5 : 1, anchor: .topLeading)
                            .offset(x: 0.0, y: isEditing ? -10 : 0.0)
                            .foregroundColor(isEditing ? color ?? Color("noFocus"): Color("noFocus"))
                        TextField("", text: $text).onChange(of: text) { value in
                            withAnimation {
                                isEditing = text.count >= 1
                            }
                        }
                    }
                    
                    if let trailingIcon =  trailingIcon {
                        Image(systemName: trailingIcon)
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color("noFocus"))
                            .onTapGesture {
                                if let action = trailingIconAction {
                                    action()
                                }
                            }
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 10)
            .frame(width: 280, height: 48, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius:5)
                    .strokeBorder(isEditing ? color ?? Color("noFocus") : Color("noFocus"),
                                  lineWidth: isEditing ? 2.0 : 1.0)
            )
            
            if let helperText =  helperText {
                Text(helperText)
                    .font(Font.system(size: 12, design: .default))
                    .padding(.leading, 16)
                    .padding(.trailing, 10)
                    .frame(width: 280,height: 16,alignment: .leading)
                    .foregroundColor(helperColor ?? Color("noFocus"))
            }
        }
    }
}

struct GTextField_Previews: PreviewProvider {
    static var previews: some View {
        GTextField(text: .constant(""), labelText: "Label Text")
    }
}
