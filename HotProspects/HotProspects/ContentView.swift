//
//  ContentView.swift
//  HotProspects
//
//  Created by Tiago Camargo Maciel dos Santos on 17/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsBuilderView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsBuilderView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsBuilderView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
