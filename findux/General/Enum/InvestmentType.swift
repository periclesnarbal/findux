//
//  InvestmentType.swift
//  findux
//
//  Created by Péricles Narbal on 22/11/23.
//

import Foundation

enum InvestmentType: String {
    case CDB_LC = "CDB/LC"
    case LCI_LCA = "LCI/LCA"
    case TESOURO = "Tesouro"
    
    init(rawValue: String) {
        switch rawValue {
        case "CDB/LC": self = .CDB_LC
        case "LCI/LCA": self = .LCI_LCA
        case "Tesouro": self = .TESOURO
        default: self = .CDB_LC
        }
    }
}
