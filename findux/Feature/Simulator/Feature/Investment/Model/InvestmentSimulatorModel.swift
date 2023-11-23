//
//  InvestmentSimulatorModel.swift
//  findux
//
//  Created by Péricles Narbal on 22/11/23.
//

import Foundation

struct InvestmentSimulatorModel {
    let investmentType: InvestmentType
    let fixType: InvestmentFixType
    let termType: MonthYear
    let profitRateType: MonthYear
    let initialValue: Double
    let montlyValue: Double
    let termValue: Double
    let profitRateValue: Double
}

struct InvestmentSimulatorDetailModel {
    let investmentType: String
    let fixType: String
    let initialValue: String
    let montlyValue: String
    let termValue: String
    let profitRateValue: String
    
    init(investmentSimulatorModel: InvestmentSimulatorModel) {
        investmentType = investmentSimulatorModel.investmentType.rawValue
        fixType = investmentSimulatorModel.fixType.rawValue
        initialValue = investmentSimulatorModel.initialValue.formatAsCurrency()
        montlyValue = investmentSimulatorModel.montlyValue.formatAsCurrency()
        termValue = "\(investmentSimulatorModel.termValue.toStringIntOrDecimal()) \(investmentSimulatorModel.termType.rawValue)"
        profitRateValue = "\(investmentSimulatorModel.profitRateType == .year ? investmentSimulatorModel.profitRateValue : investmentSimulatorModel.profitRateValue * 12)% a.a"
    }
}

struct InvestmentSimulatorDetailResultModel {
    let investmentAmount: String
    let incomeValue: String
    let finalFull: String
    let discountIR: String
    let finalValue: String
}
