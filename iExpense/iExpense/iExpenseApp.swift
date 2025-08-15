//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Tiago Camargo Maciel dos Santos on 19/05/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
