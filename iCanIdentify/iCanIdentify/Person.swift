//
//  Person.swift
//  iCanIdentify
//
//  Created by Tiago Camargo Maciel dos Santos on 15/07/25.
//

import Foundation
import CoreLocation
import SwiftData
import SwiftUI

@Model
class Person {
    var id: UUID
    var name: String
    var summary: String
    var longitude: Double
    var latitude: Double
    @Attribute(.externalStorage) var photo: Data
    
    init(id: UUID, name: String, summary: String, longitude: Double, latitude: Double, photo: Data) {
        self.id = id
        self.name = name
        self.summary = summary
        self.longitude = longitude
        self.latitude = latitude
        self.photo = photo
    }
    
    func convertDataToImage() -> UIImage? {
        return UIImage(data: photo)
    }
}
