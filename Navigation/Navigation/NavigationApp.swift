//
//  NavigationApp.swift
//  Navigation
//
//  Created by Tiago Camargo Maciel dos Santos on 28/05/25.
//

import SwiftUI

@main
struct NavigationApp: App {
    @State private var pathStore = PathStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(pathStore)
        }
    }
}
