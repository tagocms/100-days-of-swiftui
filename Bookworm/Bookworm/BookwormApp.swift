//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tiago Camargo Maciel dos Santos on 11/06/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BookModel.self)
    }
}
