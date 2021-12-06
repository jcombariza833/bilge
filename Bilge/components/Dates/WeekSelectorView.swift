//
//  WeekSelectorView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/17/21.
//

import SwiftUI

struct WeekSelectorView: View {
    @ObservedObject var viewModel: ClassViewModel
    
    @State private var selectionMessage = ""
    @State private var current = 0
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(viewModel.roomCode)
                .padding(.horizontal)
            HStack( spacing: 0.0) {
                ForEach(viewModel.week) { schedule in
                    Text(schedule.day)
                        .font(schedule.isActive ? .body : .caption)
                        .padding(.all, 3)
                        .overlay(
                            Rectangle().stroke(schedule.isActive ? .blue : .black, lineWidth: schedule.isActive ? 3 : 1)
                        )
                        .background(schedule.isActive ? .white : .gray.opacity(0.2))
                        .clipShape(Rectangle())
                        .onTapGesture {
                            if schedule.isActive {
                                selectionMessage = schedule.classroom
                            }
                        }.disabled(!schedule.isActive)
                }
            }.padding(.horizontal)
            
            Text(selectionMessage)
                .padding(.horizontal)
        }
    }
}

struct WeekSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        WeekSelectorView(viewModel: ClassViewModel())
    }
}
