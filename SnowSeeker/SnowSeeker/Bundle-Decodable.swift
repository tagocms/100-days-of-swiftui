//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Tiago Camargo Maciel dos Santos on 12/08/25.
//

import Foundation

extension Bundle {
    func decodeJSON<T: Decodable>(_ fileName: String) -> T {
        guard let url = self.url(forResource: fileName, withExtension: "json") else {
            fatalError("Unable to locate resource \(fileName) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to read data from the resource \(fileName) in Bundle.")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(fileName) from Bundle due to missing key \(key): \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(fileName) from Bundle due to type mismatch: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(fileName) from Bundle due to missing \(type) value: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(fileName) from Bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(fileName) from Bundle: \(error.localizedDescription)")
        }
    }
}
