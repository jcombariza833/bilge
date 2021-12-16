//
//  ClassroomView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/5/21.
//

import SwiftUI
import Combine

struct ClassroomView: View {
    @EnvironmentObject var pollManager: PollManger
    @ObservedObject var viewModel: ClassViewModel
    @EnvironmentObject var pollConnection: PollConnectionManager
    
    let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    enum ActivityType {
        case poll
        case coevaluation
        case groups
        case attendance
        case questions
    }
    
    struct IconData: Identifiable {
        var id: String { label }
        var image: String
        var label: String
        var activity: ActivityType
    }
    
    let data = [IconData(image: "chart.bar.doc.horizontal", label: "Poll", activity: .poll),
                IconData(image: "checkmark.circle", label: "Co-evaluation", activity: .coevaluation),
                IconData(image: "person.3.fill", label: "Groups", activity: .groups),
                IconData(image: "person.crop.circle.badge.checkmark", label: "Attendance", activity: .attendance),
                IconData(image: "questionmark.app", label: "Questions", activity: .questions)
    ]
    var pollList = [PollModel]()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data) { item in
                        NavigationLink {
                            activityView(activity: item.activity)
                        } label: {
                            VStack {
                                Circle()
                                    .fill()
                                    .foregroundColor(.blue)
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Image(systemName: item.image)
                                            .resizable()
                                            .foregroundColor(.white)
                                            .padding(25)
                                    )
                                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                                Text(item.label).font(.body)
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(maxHeight: 300)
            
            List {
                if viewModel.pollList.isEmpty {
                    HStack {
                        Spacer()
                        Text("No polls added")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.pollList) { poll in
                        HStack {
                            VStack {
                                Text(poll.name).bold()
                            }
                            Spacer()
                            GButton(labelText: "Share", textColor: .white, color: .blue, fullWidth: false) {
                                pollConnection.sendPoll(poll)
                            }
                        }
                        .padding()
                    }.onDelete { indexSet in
                        indexSet.forEach { i in
                            let poll = viewModel.pollList[i]
                            viewModel.deletePoll(poll: poll)
                        }
                        viewModel.pollList.remove(atOffsets: indexSet)
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Classroom")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                GToggle(colorOn: .blue, isOn: $viewModel.startOnline) {
                    HStack {
                        Spacer()
                        Text(viewModel.startOnline ? "Online" : "Offline")
                            .font(.system(.caption))
                            .foregroundColor(viewModel.startOnline ? .green : Color("noFocus"))
                    }
                }
                .frame(width: 280)
                .onChange(of: viewModel.startOnline) { newValue in
                    if newValue {
                        pollConnection.host()
                    } else {
                        pollConnection.leave()
                    }
                }
            }
        }
        .onAppear {
            viewModel.pollList = viewModel.pollListCaller.reversed()
        }
    }
    
    func activityView(activity: ActivityType) -> some View {
        switch activity {
        case .poll:
            return AnyView(CreatePoolView(viewModel: viewModel))
        case .coevaluation:
            return AnyView(Text("Coevaluation"))
        case .groups:
            return AnyView(Text("Groups"))
        case .attendance:
            return AnyView(AttendanceView())
        case .questions:
            return AnyView(Text("Questions"))
        }
    }
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomView(viewModel: ClassViewModel())
    }
}
