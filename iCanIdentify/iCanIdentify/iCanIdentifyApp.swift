//
//  iCanIdentifyApp.swift
//  iCanIdentify
//
//  Created by Tiago Camargo Maciel dos Santos on 15/07/25.
//

import SwiftData
import SwiftUI

@main
struct iCanIdentifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
