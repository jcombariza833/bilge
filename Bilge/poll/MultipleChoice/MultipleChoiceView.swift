//
//  MultipleChoiceView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI

struct MultipleChoiceView: View {
    @Binding var presentation: Bool
    @State var timeRemaining = 0
    @State var timeRunning: Float = 0.0
    @State private var selection = Set<String>()
    @State var isEditMode: EditMode = .active
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let component: MultipleChoice
    
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
            Spacer()
            Text(component.question)
            List(component.options, id: \.self, selection: $selection) { name in
                Text(name)
            }.environment(\.editMode, self.$isEditMode)
            GButton(labelText: "Send",
                    textColor: .white,
                    color: .blue,
                    fullWidth: true) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    let votes = component.options.map { option -> [String: Bool] in
                        if selection.contains(option) {
                            return [option: true]
                        }
                        
                        return [option: false]
                    }
                    let feedback = MultipleChoiceFeedBack(vote: votes)
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


struct MultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(presentation: .constant(true),
                           component: MultipleChoice(question: "Which of the following are actually animals?",
                                                time: 30,
                                                options:["Dog", "Toaster", "Apple", "Cat"]))
    }
}
