//
//  JSONManager.swift
//  findux
//
//  Created by Péricles Narbal on 26/10/23.
//

import Foundation

enum JSONManagerError: Error {
    case encodingError
    case decodingError
    case fileReadError
}

class JSONManager {
    
    static func encode<T: Encodable>(_ object: T) throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let jsonData = try encoder.encode(object)
            return jsonData
        } catch {
            print("Error encoding object to JSON: \(error)")
            throw JSONManagerError.encodingError
        }
    }
    
    static func decode<T: Decodable>(_ jsonData: Data) throws -> T {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let object = try decoder.decode(T.self, from: jsonData)
                return object
            } catch {
                print("Error decoding JSON to object: \(error)")
                throw JSONManagerError.decodingError
            }
        }
    
    static func decodeFromFile<T: Decodable>(_ filePath: String) throws -> T {
        do {
            let fileUrl = URL(fileURLWithPath: filePath)
            let jsonData = try Data(contentsOf: fileUrl)
            return try decode(jsonData)
        } catch {
            print("Error reading file or decoding JSON: \(error)")
            throw JSONManagerError.fileReadError
        }
    }
}
