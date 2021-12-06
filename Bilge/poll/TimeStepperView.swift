//
//  TimeStepper().swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI


struct TimeStepperView: View {
    var data = [5, 10, 15, 20]
    @Binding var selection: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(height: 4, alignment: .center)
                .cornerRadius(20)
            
            HStack {
                ForEach(data.indices) { i in
                    ZStack {
                        if i <= selection {
                            Circle()
                                .foregroundColor( .blue )
                                .padding(.all, 3)
                                .frame(width: selection == i ? 40 : 31, height: selection == i ? 40 : 31)
                                .overlay(
                                    Text("\(data[i])")
                                )
                        } else {
                            Circle()
                                .foregroundColor( .white )
                                .padding(.all, 3)
                                .frame(width: 31, height: 31)
                                .overlay(
                                    Circle()
                                        .strokeBorder(Color.blue, lineWidth: 3)
                                        .overlay(Text("\(data[i])"))
                                )
                        }
                    }
                    .onTapGesture {
                        selection = i
                    }
                    
                    if i < data.count - 1 {
                        Spacer()
                    }
                }
            }
        }
        .frame(height: 30)
        .padding()
    }
}


struct TimeStepperView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStepperView(selection: .constant(0))
    }
}
