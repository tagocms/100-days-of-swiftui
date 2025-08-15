//
//  Habit.swift
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//

import Foundation

struct Habit: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var iconName: String
    var dates: Set<Date> = []
    var count: Int {
        dates.count
    }
}

@Observable
class HabitModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _habits = "habits"
    }
    
    var habits: [Habit] {
        didSet {
            encodeHabits()
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "habits") {
            if let decoded = try? decoder.decode([Habit].self, from: data) {
                habits = decoded
                return
            }
        }
        
        habits = []
    }
    
    func encodeHabits() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(habits) {
            UserDefaults.standard.set(data, forKey: "habits")
        }
    }
}
