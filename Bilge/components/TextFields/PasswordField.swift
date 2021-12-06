//
//  PasswordField.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/5/21.
//

import SwiftUI

struct PasswordField: View {
    @Binding var text: String
    
    private let labelText = "Password"
    private let leadingIcon = "lock"
    private let trailingIcon = "clear"
    var helperText: String? = nil
    var color: Color? = nil
    
    @State private var isEditing = false
    @State private var showPassword = false
    
    var body: some View {
        VStack(alignment:.center) {
            ZStack(alignment:.leading) {
                HStack {
                    Image(systemName: leadingIcon)
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("noFocus"))
                    
                    ZStack(alignment: .leading ){
                        Text(labelText)
                            .scaleEffect(isEditing ? 0.5 : 1,anchor: .topLeading)
                            .offset(x: 0.0, y: isEditing ? -10 : 0.0)
                            .foregroundColor(isEditing ? color ?? Color("noFocus"): Color("noFocus"))
                        if !showPassword {
                            SecureField("", text: $text).onChange(of: text) { value in
                                withAnimation {
                                    isEditing = text.count >= 1
                                }
                            }
                        } else {
                            TextField("", text: $text).onChange(of: text) { value in
                                withAnimation {
                                    isEditing = text.count >= 1
                                }
                            }
                        }
                    }
                    
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color("noFocus"))
                        .onTapGesture {
                            showPassword.toggle()
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
            
            if let helperText =  helperText, !helperText.isEmpty {
                Text(helperText)
                    .font(Font.system(size: 12, design: .default))
                    .padding(.leading, 16)
                    .padding(.trailing, 10)
                    .frame(width: 280,height: 16,alignment: .leading)
                    .foregroundColor(.red)
            }
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(text: .constant(""))
    }
}
