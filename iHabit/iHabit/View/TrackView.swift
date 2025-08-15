//
//  TrackView.swift
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//

import SwiftUI

struct TrackView: View {
    @Binding var habitModel: HabitModel
    @State private var showAlert = false
    private let currentDate: Date = Calendar.current.startOfDay(for: Date.now)
    private var isDone: Bool {
        for habit in habitModel.habits {
            if !habit.dates.contains(currentDate) {
                return false
            }
        }
        return true
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitModel.habits.indices, id: \.self) { index in
                    HStack(spacing: 20) {
                        Image(systemName: habitModel.habits[index].iconName)
                            .resizable()
                            .scaledToFit()
                            .containerRelativeFrame([.horizontal, .vertical]) { dimension, axis in
                                if axis == .vertical {
                                    dimension * 0.4
                                } else {
                                    dimension * 0.1
                                }
                            }
                        VStack(alignment: .leading) {
                            Text(habitModel.habits[index].title)
                                .font(.headline)
                            Text("Count: \(habitModel.habits[index].count)")
                                .font(.subheadline)
                        }
                        .containerRelativeFrame(.horizontal) { dimension, _ in
                            dimension * 0.3
                        }
                        
                        Spacer()

                        Button {
                            if !habitModel.habits[index].dates.contains(currentDate) {
                                habitModel.habits[index].dates.insert(currentDate)
                                showAlert = isDone
                            } else {
                                habitModel.habits[index].dates.remove(currentDate)
                            }
                        } label: {
                            Circle()
                                .foregroundColor(!habitModel.habits[index].dates.contains(currentDate) ? .clear : .green)
                                .containerRelativeFrame([.horizontal, .vertical]) { dimension, axis in
                                    if axis == .vertical {
                                        dimension * 0.4
                                    } else {
                                        dimension * 0.1
                                    }
                                }
                                .overlay(
                                    
                                    Circle()
                                        .stroke(.gray, lineWidth: 2)
                                )
                                .overlay(
                                    Image(systemName: !habitModel.habits[index].dates.contains(currentDate) ? "" : "checkmark")
                                        .foregroundStyle(.gray)
                                )
                        }
                        
                    }
                }
            }
            .alert("All Done!", isPresented: $showAlert) {
                Button("Awesome!") { }
            } message: {
                Text("You completed all your habits for today!")
            }
            .navigationTitle("Tracker: \(currentDate.formatted(date: .abbreviated, time: .omitted))")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    @State @Previewable var habitModel = HabitModel()
    TrackView(habitModel: $habitModel)
}
