//
//  ContentView.swift
//  Navigation
//
//  Created by Tiago Camargo Maciel dos Santos on 28/05/25.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            savePath()
        }
    }
    
    let savedPath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savedPath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func savePath() {
        guard let representation = path.codable else { return }
        
        if let encoded = try? JSONEncoder().encode(representation) {
            do {
                try encoded.write(to: savedPath)
            } catch {
                print("Failed to save navigation data.")
            }
        }
    }
}

struct InnerView: View {
    @Environment(PathStore.self) var pathStore
    
    let number: Int
    var sum: Int
    
    var body: some View {
        NavigationLink("Go to random Number.", value: Int.random(in: 0...10))
            .navigationTitle("Number = \(number) (\(sum))")
            .toolbar {
                Button {
                    pathStore.path = NavigationPath()
                } label: {
                    Text("Home")
                }
            }
    }
}

struct ContentView: View {
    @Environment(PathStore.self) var pathStore
    
    
    var body: some View {
        @Bindable var ps = pathStore
        
        NavigationStack(path: $ps.path) {
            InnerView(number: 0, sum: 0)
                .navigationDestination(for: Int.self) {
                    InnerView(number: $0, sum: ps.path.count)
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(PathStore())
}
