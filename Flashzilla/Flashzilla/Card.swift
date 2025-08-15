//
//  Card.swift
//  Flashzilla
//
//  Created by Tiago Camargo Maciel dos Santos on 30/07/25.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What is Swift?", answer: "A high-level programming language")
    
    static func saveToDocumentsDirectory(cards: [Card], fileName: String) {
        let encoder = JSONEncoder()
        let url = URL.documentsDirectory.appending(path: fileName)
        
        if let encoded = try? encoder.encode(cards) {
            do {
                try encoded.write(to: url, options: [.atomic, .completeFileProtection])
                print("Cards array saved successfully to \(fileName).")
                return
            } catch {
                print("Cards array not saved to \(fileName).")
                return
            }
            
        } else {
            print("Cards array not saved to \(fileName).")
            return
        }
    }
    
    static func loadFromDocumentsDirectory(fileName: String) -> [Card] {
        let decoder = JSONDecoder()
        let url = URL.documentsDirectory.appending(path: fileName)
        
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? decoder.decode([Card].self, from: data) {
                return decoded
            }
        }
        
        return []
    }
}
