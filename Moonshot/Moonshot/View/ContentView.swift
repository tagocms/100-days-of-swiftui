//
//  ContentView.swift
//  Moonshot
//
//  Created by Tiago Camargo Maciel dos Santos on 22/05/25.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [ GridItem(.adaptive(minimum: 150))]
    
    @State private var isLayoutGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isLayoutGrid {
                    MainGridView(astronauts: astronauts, missions: missions, columns: columns)
                } else {
                    MainListView(astronauts: astronauts, missions: missions)
                }
                    
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            isLayoutGrid.toggle()
                        }
                    } label: {
                        HStack {
                            Text(isLayoutGrid ? "Switch to list" : "Switch to grid")
                            Image(systemName: isLayoutGrid ? "list.bullet" : "square.grid.2x2")
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
