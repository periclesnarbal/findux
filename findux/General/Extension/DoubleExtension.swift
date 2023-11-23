//
//  DoubleExtension.swift
//  findux
//
//  Created by Péricles Narbal on 22/11/23.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")

        if let formattedString = formatter.string(from: self as NSNumber) {
            return formattedString
        } else {
            return "Error"
        }
    }
    
    func toStringIntOrDecimal() -> String {
        let isInteger = self.truncatingRemainder(dividingBy: 1) == 0
        let roundedValue = self.roundedNearTwoDecimal()
        let formatedResult = isInteger ? String(format: "%.0f", roundedValue) : String(format: "%.2f", roundedValue)
        return formatedResult
    }
    
    func roundedNearTwoDecimal() -> Double {
        return (self * 100).rounded() / 100
    }
}
