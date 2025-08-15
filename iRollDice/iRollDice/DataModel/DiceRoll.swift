//
//  DiceThrown.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import Foundation
import SwiftData

@Model
class DiceRoll {
    var id: UUID
    var date: Date
    @Relationship(deleteRule: .cascade) var dice: [Die] = [Die]()
    
    var totalThrown: Int {
        var sum = 0
        
        for die in dice {
            sum += die.numberThrownUnwrapped
        }
        
        return sum
    }
    var formattedDate: String {
        return date.formatted(date: .abbreviated, time: .shortened)
    }
    
    init(id: UUID = UUID(), date: Date = Date.now, dice: [Die]) {
        self.id = id
        self.date = date
        self.dice = dice
    }
}
