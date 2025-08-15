//
//  Prospect.swift
//  HotProspects
//
//  Created by Tiago Camargo Maciel dos Santos on 22/07/25.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded: Date
    
    init(name: String, emailAddress: String, isContacted: Bool, dateAdded: Date = Date.now) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.dateAdded = dateAdded
    }
}
