//
//  HabitView.swift
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//

import SwiftUI

struct HabitView: View {
    let icons = Icons()
    @Binding var habit: Habit
    @State private var isDisabled = true
    
    var body: some View {
        ZStack {
            Color.whiteSmoke
                .ignoresSafeArea()
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    if !isDisabled {
                        VStack(alignment: .leading) {
                            Text("Title")
                                .font(.title2.bold())
                            TextField("Title", text: $habit.title)
                                .font(.body)
                                .disabled(isDisabled)
                                .padding(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isDisabled ? .gray : .black, lineWidth: 1)
                                )
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.title2.bold())
                        TextField("Description", text: $habit.description)
                            .font(.body)
                            .disabled(isDisabled)
                            .padding(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(isDisabled ? .gray : .black, lineWidth: 1)
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Icon")
                            .font(.title2.bold())
                        Picker("Icon", selection: $habit.iconName) {
                            ForEach(icons.iconNames, id: \.self) { iconName in
                                Image(systemName: iconName)
                            }
                        }
                        .tint(.black)
                        .padding(12)
                        .disabled(isDisabled)
                    }
                    VStack(alignment: .leading) {
                        Text("Count")
                            .font(.title2.bold())
                        Text("\(habit.count)")
                            .font(.headline)
                            .padding(12)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .background(.thinMaterial)
            
        }
        .navigationTitle(isDisabled ? habit.title : "")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        isDisabled.toggle()
                    }
                } label: {
                    Text(isDisabled ? "Edit" : "Done")
                }
            }
        }
    }
}

#Preview {
    @State @Previewable var habitModel = HabitModel()
    HabitView(habit: $habitModel.habits[0])
}
