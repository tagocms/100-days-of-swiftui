//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tiago Camargo Maciel dos Santos on 18/06/25.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    var id: UUID
    var name: String
    var type: String
    var value: Double
    
    init(id: UUID = UUID(), name: String, type: String, value: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.value = value
    }
}
