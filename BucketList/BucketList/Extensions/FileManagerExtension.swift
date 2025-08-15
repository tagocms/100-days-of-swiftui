//
//  FileManagerExtension.swift
//  BucketList
//
//  Created by Tiago Camargo Maciel dos Santos on 02/07/25.
//

import Foundation

extension FileManager {
    static func writeDataToFile<T: Codable>(rawData: T, fileName: String) throws {
        let data = try JSONEncoder().encode(rawData)
        let url = URL.documentsDirectory.appending(path: fileName)
        
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
    
    static func readDataFromFile(fileName: String) throws -> Data {
        let url = URL.documentsDirectory.appending(path: fileName)
        
        let data = try Data(contentsOf: url)
        
        return data
    }
}
