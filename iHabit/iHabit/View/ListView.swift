//
//  ListView.swift
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//

import SwiftUI

struct ListView: View {
    @Binding var habitModel: HabitModel
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitModel.habits.indices, id: \.self) { index in
                    NavigationLink(value: index) {
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
                        }
                    }
                }
                .onDelete(perform: deleteHabit)
            }
            .navigationDestination(for: Int.self) { index in
                HabitView(habit: $habitModel.habits[index])
            }
            .sheet(isPresented: $showSheet) {
                CreateHabit(habitModel: $habitModel)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Add Habit")
                    }
                }
            }
        }
        .navigationTitle("Habit Manager")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func deleteHabit(indexSet: IndexSet) {
        habitModel.habits.remove(atOffsets: indexSet)
    }
}

#Preview {
    @State @Previewable var habitModel = HabitModel()
    ListView(habitModel: $habitModel)
}
