//
//  StringExtension.swift
//  findux
//
//  Created by Péricles Narbal on 16/11/23.
//

import Foundation

extension String {
    func toDecimalCurrency() -> String {
        guard let number = Int(self) else { return self }
        let decimal = Double(number) / 100.0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.minimumFractionDigits = 2
        formatter.alwaysShowsDecimalSeparator = true
        
        if let formattedString = formatter.string(from: NSNumber(value: decimal)) {
            return formattedString
        }
        
        return self
    }
    
    func fromDecimalCurrency() -> String {
        return removeCommas(from: self)
    }
    
    func removeCommas(from text: String) -> String {
        let stringWithoutCommas = text.replacingOccurrences(of: ",", with: "")
        return stringWithoutCommas
    }
    
    func replacingDotsForCommas() -> String {
        return self.replacingOccurrences(of: ".", with: ",")
    }
    
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.locale = Locale(identifier: "pt_BR")
        
        if let number = formatter.number(from: self) {
            return number.doubleValue
        }
        
        return nil
    }
}
