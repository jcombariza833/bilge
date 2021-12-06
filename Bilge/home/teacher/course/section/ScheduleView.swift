//
//  ScheduleView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/4/21.
//

import SwiftUI
import Combine

struct ScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    
    struct AlertDetails: Identifiable {
        var id: String { message }
        let message: String
    }
    
    @State var details: AlertDetails?
    @State var showAlert = false
    
    var body: some View {
        List {
            Section("Select a day a day") {
                VStack {
                    Picker("Student limit", selection: $viewModel.schedule) {
                        ForEach(viewModel.schedules) { schedule in
                            Text(schedule.day)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    Text(viewModel.day)
                    
                    TextField("classroom", text: $viewModel.classroom)
                        .padding(.horizontal).padding(.vertical, 8)
                        .clipShape(Rectangle())
                        .overlay(
                            Rectangle()
                                .strokeBorder(.gray,lineWidth: 1))
                        .font(.subheadline)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    
                    
                }
                HStack {
                    Spacer()
                    addButton
                    Spacer()
                }
            }
            
            Section("Selected days") {
                if viewModel.activeSchedules.isEmpty {
                    Text("No days added")
                } else {
                    ForEach(viewModel.activeSchedules) { data in
                        HStack {
                            Text(data.day)
                            Spacer()
                            Text(data.classroom)
                        }.padding(.horizontal)
                    }.onDelete { index in
                        index.forEach { i in
                            let schedule = viewModel.activeSchedules[i]
                            let index = viewModel.schedules.firstIndex(of: schedule) ?? 0
                            viewModel.schedules.remove(at: index)
                            viewModel.schedules.insert(ScheduleData(day: schedule.day,
                                                                    classroom: "",
                                                                    isActive: false),
                                                       at: index)
                        }
                    }
                }
            }
        }
        .navigationTitle("Schedule")
    }
    
    var addButton: some View {
        Button(action: {
            if viewModel.classroom.isEmpty {
                details = AlertDetails(message: "Classroom cannot be empty")
                showAlert.toggle()
            } else {
                if viewModel.schedules.first(where: { $0.day == viewModel.schedule && $0.isActive == true }) != nil {
                    details = AlertDetails(message: "This day was already selected")
                    showAlert.toggle()
                } else {
                    let schedule = viewModel.schedules.first(where: { $0.day == viewModel.schedule }) ?? ScheduleData(day: "",
                                                                                                                      classroom: "",
                                                                                                                      isActive: false)
                    let index = viewModel.schedules.firstIndex(of: schedule) ?? 0
                    viewModel.schedules.remove(at: index)
                    viewModel.schedules.insert(ScheduleData(day: schedule.day,
                                                            classroom: viewModel.classroom,
                                                            isActive: true),
                                               at: index)

                }
            }
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.body)
                    .padding(.all, 4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("Add")
                    .font(.body)
                    .foregroundColor(.blue)
            }
        }
        .alert("", isPresented: $showAlert, presenting: details) { detail in
            Button("OK", role: .cancel) {

            }
        } message: { detail in
            Text(detail.message)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: ScheduleViewModel())
    }
}
