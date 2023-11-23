//
//  MonthYear.swift
//  findux
//
//  Created by Péricles Narbal on 22/11/23.
//

import Foundation

enum MonthYear: String {
    case month = "Mês(es)"
    case year = "Ano(s)"
    
    init(rawValue: String) {
        switch rawValue {
        case "Mês", "Meses": self = .month
        case "Ano", "Anos": self = .year
        default: self = .year
        }
    }
}
