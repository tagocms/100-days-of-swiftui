//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Tiago Camargo Maciel dos Santos on 13/08/25.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decodedData = try? decoder.decode(Set<String>.self, from: data) {
                resorts = decodedData
                return
            }
        }
        
        // If there is no data in the key "Favorites", initialize resorts as an empty set.
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(resorts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
