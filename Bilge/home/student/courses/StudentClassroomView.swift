//
//  StudentClassroomView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import SwiftUI
import Foundation

struct StudentClassroomView: View {
    @EnvironmentObject var pollManager: PollManger
    @EnvironmentObject var pollConnection: PollConnectionManager
    @ObservedObject var viewModel: EnrolledCourseListViewModel
    
    @State private var tabSelection = 1
    
    var body: some View {
        ZStack {
            if pollConnection.receivedPollNotifier != nil {
                VStack {
                    TabView(selection: $tabSelection) {
                        ForEach((0...pollConnection.receivedPoll.components.count-1), id: \.self) { i in
                            getView(i: i)
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                    Text(pollConnection.receivedPoll.name)
                    Text(pollConnection.receivedPoll.courseCode)
                    Text(pollConnection.receivedPoll.sectionCode)
                }
            } else {
                Text("Waiting for the polls")
            }
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Classroom")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                GToggle(colorOn: .blue, isOn: $viewModel.isReceivingPolls) {
                    HStack {
                        Spacer()
                        Text(viewModel.isReceivingPolls ? "Online" : "Offline")
                            .font(.system(.caption))
                            .foregroundColor(viewModel.isReceivingPolls ? .green : Color("noFocus"))
                    }
                }
                .frame(width: 280)
                .onChange(of: viewModel.isReceivingPolls) { newValue in
                    if newValue {
                        pollConnection.join()
                    } else {
                        pollConnection.leave()
                    }
                }
            }
        }
        .onAppear {
            pollConnection.configuration(service: viewModel.service, username: viewModel.username)
        }
        .onDisappear {
            viewModel.isReceivingPolls = false
        }
    }
    
    func getView(i: Int) -> AnyView {
        let type = pollConnection.receivedPoll.components[i].type
        let component = pollConnection.receivedPoll.components[i]
        
        return getComponent(type: type, component: component)
    }
    
    func getComponent(type: PollComponentType, component: PollComponent) -> AnyView {
        switch type {
        case .statement:
            let componentN = component as! Statement
            return AnyView(StatementView(presentation: .constant(true),
                                         component: componentN,
                                         preview: false) {
                pollConnection.receivedPollNotifier = nil
            }
            )
        case .multipleChoice:
            let componentN = component as! MultipleChoice
            return AnyView(MultipleChoiceView(presentation: .constant(true),
                                         component: componentN,
                                              preview: false) {
                pollConnection.receivedPollNotifier = nil
            }
            )
        case .selection:
            let componentN = component as! Selection
            return AnyView(SelectionView(presentation: .constant(true),
                                         component: componentN,
                                         preview: false) {
                pollConnection.receivedPollNotifier = nil
            }
            )
        case .agree:
            let componentN = component as! Agree
            return AnyView(AgreeView(presentation: .constant(true),
                                         component: componentN,
                                     preview: false) {
                pollConnection.receivedPollNotifier = nil
            }
            )
        }
    }
}

struct StudentClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        StudentClassroomView(viewModel: EnrolledCourseListViewModel())
    }
}


public struct Stack<Element> {
  private var storage: [Element] = []
  public init() { }
}
extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "----top----\n"
        let bottomDivider = "\n-----------"
        let stackElements = storage
          .map { "\($0)" }
          .reversed()
          .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    public func peek() -> Element? {
        return storage.last
    }
    
    public var isEmpty: Bool {
        return peek() == nil
    }
    
    public init(_ elements: [Element]) {
      storage = elements
    }
}
