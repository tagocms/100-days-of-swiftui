//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tiago Camargo Maciel dos Santos on 06/06/25.
//

import Foundation

@Observable
class Order: Codable {
    struct DeliveryAddress: Codable {
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
    }
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _deliveryAddress = "deliveryAddress"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var deliveryAddress: DeliveryAddress {
        didSet {
            saveAddress()
        }
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    
    
    var hasValidAddress: Bool {
        if deliveryAddress.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || deliveryAddress.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || deliveryAddress.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || deliveryAddress.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) * 0.5
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }
        
        return cost
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let savedData = UserDefaults.standard.data(forKey: "savedAddress") {
            if let decodedData = try? decoder.decode(DeliveryAddress.self, from: savedData) {
                self.deliveryAddress = decodedData
                return
            }
        }
        
        self.deliveryAddress = DeliveryAddress()
    }
    
    func saveAddress() {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(deliveryAddress) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: "savedAddress")
    }
}
