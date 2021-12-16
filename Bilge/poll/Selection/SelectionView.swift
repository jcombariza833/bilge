//
//  SelectionView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI
struct SelectionView: View {
    @Binding var presentation: Bool
    @State var timeRemaining = 0
    @State var timeRunning: Float = 0.0
    @State private var selection: String?
    @State var isEditMode: EditMode = .active
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let component: Selection
    let preview: Bool
    var action: (() -> ())?
    
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
            Spacer()
            Text(component.question)
            List(component.options, id: \.self, selection: $selection) { name in
                Text(name)
            }
            .environment(\.editMode, self.$isEditMode)
            
            GButton(labelText: "Send",
                    textColor: .white,
                    color: .blue,
                    fullWidth: true) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    if !preview {
                        if let selection = selection {
                            let feedback = SelectionFeedBack(vote: [selection: true])
                            //send feedback
                        }
                        
                        //presentation.toggle()
                        if let action = action {
                            action()
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            timeRemaining = component.time
            timeRunning = 0.0
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(presentation: .constant(true),
                      component: Selection(question: "Whichone of the following is an actually animal?",
                                           time: 30,
                                           options:["Dog", "Toaster", "Apple", "Truck"]), preview: false)
    }
}
