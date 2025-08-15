//
//  iHaveFriendsApp.swift
//  iHaveFriends
//
//  Created by Tiago Camargo Maciel dos Santos on 24/06/25.
//

import SwiftData
import SwiftUI

@main
struct iHaveFriendsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
