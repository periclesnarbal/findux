//
//  UserDefaultsManager.swift
//  findux
//
//  Created by Péricles Narbal on 21/09/23.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    func createItem<T>(_ key: String, value: T) {
        userDefaults.set(value, forKey: key)
    }
    
    func createItem<T: Encodable>(_ key: String, value: T) {
        let data = try? JSONEncoder().encode(value)
        userDefaults.set(data, forKey: key)
    }
    
    func readItem<T>(_ key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
    func readItem<T: Decodable>(_ key: String) -> T? {
        if let data = userDefaults.value(forKey: key) as? Data {
            let object = try? JSONDecoder().decode(T.self, from: data)
            return object
        }
        return nil
    }
    
    func updateItem<T>(_ key: String, newValue: T) {
        userDefaults.set(newValue, forKey: key)
    }
    
    func deleteItem(_ key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func showAllItems() -> [String: Any] {
        var allItems: [String: Any] = [:]
        
        let allKeys = userDefaults.dictionaryRepresentation().keys
        for key in allKeys {
            if let value = userDefaults.value(forKey: key) {
                allItems[key] = value
            }
        }
        
        return allItems
    }
    
    func deleteAllItems() {
        let allKeys = userDefaults.dictionaryRepresentation().keys
        for key in allKeys {
            userDefaults.removeObject(forKey: key)
        }
    }
}

