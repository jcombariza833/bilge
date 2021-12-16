//
//  CreatePoolView.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/29/21.
//

import SwiftUI
import Combine

struct CreatePoolView: View {
    @EnvironmentObject var pollManager: PollManger
    @ObservedObject var viewModel: ClassViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showPreview = false
    @State var showSaveAlert = false
    @State var selection = 0
    
    var rows = [GridItem(.flexible())]
        
    var body: some View {
        VStack {
            if !pollManager.components.isEmpty {
                pollPannel
            }
           
            ForEach(PollComponentType.allCases, id: \.self) { component in
                NavigationLink {
                    component.view().environmentObject(self.pollManager)
                } label: {
                    Rectangle()
                        .fill()
                        .frame(width: nil,height: 80, alignment: .center)
                        .overlay(
                            HStack {
                                Spacer()
                                Text(component.toString())
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()
                                Image(systemName: component.icon())
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding(.horizontal,25)
                            })
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .fill()
                                            .foregroundColor(.white)
                                            .frame(width: 24, height: 24)
                                        Text("\(pollManager.counters[component.toString()] ?? 0)")
                                    }.offset(x: 12, y: 12)
                                }
                            }
                        )
                    .padding()
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                }
            }
            Spacer()

        }
        .navigationBarTitleDisplayMode( .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if pollManager.name.isEmpty || pollManager.components.isEmpty {
                        showSaveAlert.toggle()
                    } else {
                        
                        let poll = Poll(name: pollManager.name,
                                       components: pollManager.components,
                                        courseCode: viewModel.courseCode, sectionCode: viewModel.sectionCode)
                        pollManager.savePoll(poll: poll)
                    }
                    
                    
                }
                .alert("You must name your poll or add at least one component",isPresented: $showSaveAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            
            
            ToolbarItem(placement: .principal) {
                HStack {
                    TextField("", text: $pollManager.name, prompt: Text("Name")).padding()
                }
                .frame(height: 40)
                .background(Color.gray.opacity(0.1))
                .overlay(
                    Rectangle()
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                ).padding(.horizontal)
            }
        }
    }
    
    var pollPannel: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach((0...pollManager.components.count-1), id: \.self) { i in
                    pollItem(i: i)
                        .sheet(isPresented: $showPreview) {
                            NavigationView {
                                HStack {
                                    if pollManager.components[selection].type == .statement {
                                        let component = pollManager.components[selection] as! Statement
                                        StatementView(presentation: .constant(true), component: component, preview: true)
                                    } else if pollManager.components[selection].type == .selection {
                                        let component = pollManager.components[selection] as! Selection
                                        SelectionView(presentation: .constant(true), component: component, preview: true)
                                    } else if pollManager.components[selection].type == .multipleChoice {
                                        let component = pollManager.components[selection] as! MultipleChoice
                                        MultipleChoiceView(presentation: .constant(true), component: component, preview: true)
                                    } else if pollManager.components[selection].type == .agree {
                                        let component = pollManager.components[selection] as! Agree
                                        AgreeView(presentation: .constant(true), component: component, preview: true)
                                    }
                                } .navigationBarTitle("Preview")
                            }
                        }
                }
            }.padding()
        }
        .frame( height: 60)
        .padding(.horizontal)
    }
    
    func pollItem(i: Int) -> some View {
        Circle()
            .fill()
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .overlay(Text("\(i+1)"))
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
            .onTapGesture {
                showPreview.toggle()
                selection = i
            }
    }
}

struct CreatePoolView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreatePoolView(viewModel: ClassViewModel()).environmentObject(PollManger())
        }
    }
}
