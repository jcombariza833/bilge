//
//  StatementFormView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI

struct StatementFormView: View {
    @EnvironmentObject var pollManager: PollManger
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var question = ""
    @State private var option1 = ""
    @State private var option2 = ""
    
    @State private var selection = 5
    @State private var error = false
    
    var times = [5,10,15,20]
    
    enum Field {
        case question
        case option1
        case option2
    }
    
    @FocusState private var focusedField: Field?
    
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
                .focused($focusedField, equals: .question)
                .submitLabel(.next)
            
            Text("Answer:")
                .font(.body)
                .bold()
                .foregroundColor(.primary)
            
            VStack {
                HStack {
                    TextField("", text: $option1, prompt: Text("Option 1"))
                        .padding()
                        .focused($focusedField, equals: .option1)
                        .submitLabel(.next)
                }
                .frame(height: 40)
                .background(Color.gray.opacity(0.1))
                .overlay(
                    Rectangle()
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                ).padding(.horizontal)
                  
                HStack {
                    TextField("", text: $option2, prompt: Text("Option 2"))
                        .padding()
                        .focused($focusedField, equals: .option1)
                        .submitLabel(.send)
                }
                .frame(height: 40)
                .background(Color.gray.opacity(0.1))
                .overlay(
                    Rectangle()
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                ).padding(.horizontal)
            }
                
            Spacer()
            
            HStack {
                Spacer()
                GButton(labelText: "Save",
                        textColor: .white,
                        color: .blue,
                        fullWidth: true) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        if question.isEmpty || option1.isEmpty || option2.isEmpty {
                            error.toggle()
                        } else {
                            let component = Statement(question: question,
                                                 option1: option1,
                                                 option2: option2,
                                                 time: selection)
                            
                            let counters = pollManager.counters
                            var count = counters[PollComponentType.statement.toString()] ?? 0
                            count+=1
                            
                            pollManager.counters[PollComponentType.statement.toString()] = count
                            pollManager.components.append(component)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding()
                .frame(width: 120)
            }
        }.onSubmit {
            switch focusedField {
            case .question:
                focusedField = .option1
            case .option1:
                focusedField = .option2
            default:
                print("Creating account…")
            }
        }.alert("All the fields must be filled out", isPresented: $error) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct StatementFormView_Previews: PreviewProvider {
    static var previews: some View {
        StatementFormView()
    }
}
