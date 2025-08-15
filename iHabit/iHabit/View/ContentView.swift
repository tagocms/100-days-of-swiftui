//
//  ContentView.swift
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var habitModel = HabitModel()
    
    
    var body: some View {
        TabView {
            Tab("Manager", systemImage: "list.bullet.circle") {
                ListView(habitModel: $habitModel)
            }
            
            Tab("Tracker", systemImage: "checkmark.circle") {
                TrackView(habitModel: $habitModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
