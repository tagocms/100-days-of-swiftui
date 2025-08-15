//
//  iRollDiceApp.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import SwiftData
import SwiftUI

@main
struct iRollDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DiceRoll.self)
    }
}
