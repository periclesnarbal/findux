//
//  IRPFRate.swift
//  findux
//
//  Created by Péricles Narbal on 23/11/23.
//

import Foundation

enum IRPFRate: Double {
    case seis_meses = 22.5
    case doze_meses = 20.0
    case vinte_quatro_meses = 17.5
    case maximo = 15.0
    
    init(months rawValue: Double) {
        switch rawValue {
        case 0...6: self = .seis_meses
        case 6.1...12: self = .doze_meses
        case 12.1...24: self = .vinte_quatro_meses
        case 24...1200: self = .maximo
        default: self = .seis_meses
        }
    }
}
