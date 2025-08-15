//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Tiago Camargo Maciel dos Santos on 17/06/25.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
