//
//  MultipleChoiceFormView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI
import Combine


struct MultipleChoiceFormView: View {
    @EnvironmentObject var pollManager: PollManger
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var question = ""
    @State private var options = [String]()
    
    @State private var selection = 5
    @State private var error = false
    
    var times = [5,10,15,20]
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            Text("Time:")
                .font(.body)
                .bold()
                .foregroundColor(.primary)
            
            Picker("Student limit", selection: $selection) {
                ForEach(times, id:\.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Text("Question:")
                .font(.body)
                .bold()
                .foregroundColor(.primary)
            
            TextEditor(text: $question)
                .background(Color.gray.opacity(0.1))
                .overlay(
                    Rectangle()
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                )
                .padding(.horizontal)
                .frame(height: 150)
                
            
            Text("Answer:")
                .font(.body)
                .bold()
                .foregroundColor(.primary)
            
            List {
                ForEach(Array(options.enumerated()), id: \.0) { i, _ in
                    HStack {
                        TextField("", text: $options[i], prompt: Text("Option \(i+1)"))
                            .padding()
                    }
                    .frame(height: 40)
                    .background(Color.gray.opacity(0.1))
                    .overlay(
                        Rectangle()
                            .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                    )
                    .padding(.horizontal)
                }
                .onDelete(perform: delete)
            }
                
            Spacer()
            
            HStack {
                GButton(labelText: "Add",
                        textColor: .white,
                        color: .blue,
                        fullWidth: true) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        options.append("")
                    }
                }
                .padding()
                .frame(width: 120)
                Spacer()
                GButton(labelText: "Save",
                        textColor: .white,
                        color: .blue,
                        fullWidth: true) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        if question.isEmpty || options.filter({ $0.isEmpty }).count > 0 || options.isEmpty {
                            error.toggle()
                        } else {
                            let component = MultipleChoice(question: question,
                                                      time: selection,
                                                      options: options)
                            
                            let counters = pollManager.counters
                            var count = counters[PollComponentType.multipleChoice.toString()] ?? 0
                            count+=1
                            
                            pollManager.counters[PollComponentType.multipleChoice.toString()] = count
                            pollManager.components.append(component)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding()
                .frame(width: 120)
            }
        }
        .alert("All the fields must be filled out", isPresented: $error) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func delete(at offsets: IndexSet) {
            options.remove(atOffsets: offsets)
        }
}


struct MultipleChoiceFormView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceFormView()
    }
}
