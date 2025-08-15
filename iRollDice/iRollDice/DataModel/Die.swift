//
//  Dice.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import Foundation
import SwiftData

@Model
class Die {
    var id: UUID
    var numberOfSides: NumberOfSides
    var numberThrown: Int?
    var roll: DiceRoll?
    
    var numberThrownUnwrapped: Int {
        if let numberThrown {
            return numberThrown
        } else {
            return 0
        }
    }
    
    init(id: UUID = UUID(), numberSides: NumberOfSides) {
        self.id = id
        self.numberOfSides = numberSides
        self.numberThrown = nil
    }
    
    func rollDie() {
        let number = Int.random(in: 1...numberOfSides.rawValue)
        numberThrown = number
    }
}

enum NumberOfSides: Int, CaseIterable, Codable, Identifiable, Equatable {
    case four = 4
    case six = 6
    case eight = 8
    case ten = 10
    case twelve = 12
    case twenty = 20
    case hundred = 100
    
    var id: Self { self }
}
