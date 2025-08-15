//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Tiago Camargo Maciel dos Santos on 17/07/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
