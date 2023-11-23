//
//  InvestmentFixType.swift
//  findux
//
//  Created by Péricles Narbal on 22/11/23.
//

import Foundation

enum InvestmentFixType: String {
    case PRE = "Pré"
    case CDI = "CDI"
    case IPCA = "IPCA"
    
    init(rawValue: String) {
        switch rawValue {
        case "Pré": self = .PRE
        case "CDI": self = .CDI
        case "IPCA": self = .IPCA
        default: self = .PRE
        }
    }
}
