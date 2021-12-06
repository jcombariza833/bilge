//
//  AgreeView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI

struct AgreeView: View {
    @Binding var presentation: Bool
    @State var timeRemaining = 0
    @State var timeRunning: Float = 0.0
    @State private var selection: String?
    @State var isEditMode: EditMode = .active
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let component: Agree
    
    @State private var level: Double = 0
    
    var body: some View {
        VStack {
            ProgressBarView(value: $timeRunning).frame(height: 20)
            Text("\(timeRemaining)")
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                                timeRunning += 1.0/Float(component.time)
                            } else {
                                presentation.toggle()
                            }
                        }

            Text(component.question)
            Slider(value: $level, in: 0...100)
            GButton(labelText: "Send",
                    textColor: .white,
                    color: .blue,
                    fullWidth: true) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    let feedback = AgreeFeedBack(vote: Int(level))
                    //send feedback
                    presentation.toggle()
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            timeRemaining = component.time
        }
    }
}

struct AgreeView_Previews: PreviewProvider {
    static var previews: some View {
        AgreeView(presentation: .constant(true), component: Agree(question: "How clear is the lecture?",
                                                             time: 30))
    }
}
