//
//  StatementView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI

struct StatementView: View {
    @Binding var presentation: Bool
    let component: Statement
    let preview: Bool
    var action: (() -> ())?
    
    @State var timeRemaining = 0
    @State var timeRunning: Float = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            ProgressBarView(value: $timeRunning).frame(height: 20)
            Text("\(timeRemaining)")
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                                timeRunning += 1.0/Float(component.time)
                            } else {
                                if !preview {
                                    //presentation.toggle()
                                    if let action = action {
                                        action()
                                    }
                                }
                            }
                        }

            Text(component.question).padding()
            VStack {
                GButton(labelText: component.option1,
                        textColor: .white,
                        color: .blue,
                        fullWidth: true) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        if !preview {
                            let feedback = StatementFeedBack(vote: component.option1)
                            //send feedback
                            //presentation.toggle()
                            if let action = action {
                                action()
                            }
                        }
                    }
                }
                
                GButton(labelText: component.option2,
                        textColor: .white,
                        color: .blue,
                        fullWidth: true) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        if !preview {
                            let feedback = StatementFeedBack(vote: component.option2)
                            //send feedback
                            //presentation.toggle()
                            if let action = action {
                                action()
                            }
                        }
                    }
                }
            }.padding()
            Spacer()
        }
        .padding()
        .onAppear {
            timeRemaining = component.time
            timeRunning = 0.0
        }
    }
}

struct StatementView_Previews: PreviewProvider {
    static var previews: some View {
        StatementView( presentation: .constant(true),
                       component: Statement(question: "In winter when the temperature is the colldest,Is the sky red ?",
                                                                      option1: "True",
                                                                      option2: "False",
                                            time: 30), preview: false)
    }
}
