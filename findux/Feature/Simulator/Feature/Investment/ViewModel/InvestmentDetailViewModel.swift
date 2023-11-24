//
//  InvestmentDetailViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 22/11/23.
//

import Foundation

protocol InvestmentDetailViewModelProtocol {
    var viewDelegate: InvestmentDetailViewProtocol { get }
    var investmentSimulatorModel: InvestmentSimulatorModel { get }
    
    init(viewDelegate: InvestmentDetailViewProtocol, investmentSimulatorModel: InvestmentSimulatorModel)
}

class InvestmentDetailViewModel: InvestmentDetailViewModelProtocol {
    
    unowned var viewDelegate: InvestmentDetailViewProtocol
    let investmentSimulatorModel: InvestmentSimulatorModel
    
    required init(viewDelegate: InvestmentDetailViewProtocol, investmentSimulatorModel: InvestmentSimulatorModel) {
        self.viewDelegate = viewDelegate
        self.investmentSimulatorModel = investmentSimulatorModel
        
        self.viewDelegate.viewModelDelegate = self
        self.viewDelegate.setupView(investmentSimulatorDetailModel: InvestmentSimulatorDetailModel(investmentSimulatorModel: investmentSimulatorModel))
        self.viewDelegate.setupView(investmentSimulatorDetailResultModel: calculateResult())
    }
    
    func calculateResult() -> InvestmentSimulatorDetailResultModel {
        let taxaJurosAnual = investmentSimulatorModel.profitRateType == .year ? investmentSimulatorModel.profitRateValue : investmentSimulatorModel.profitRateValue * 12
        let prazoInvestimentoMensal = investmentSimulatorModel.termType == .year ? investmentSimulatorModel.termValue * 12 : investmentSimulatorModel.termValue
        let valorTotalBruto = investimentoPrefixadoCompleto(investimentoInicial: investmentSimulatorModel.initialValue, investimentoMensal: investmentSimulatorModel.montlyValue, taxaJurosAnual: taxaJurosAnual, prazoInvestimentoMensal: prazoInvestimentoMensal)
        let valorInvestido = investmentSimulatorModel.initialValue + investmentSimulatorModel.montlyValue * prazoInvestimentoMensal
        let rendimentoBruto = valorTotalBruto - valorInvestido
        let taxaImpostoRenda = IRPFRate(months: prazoInvestimentoMensal).rawValue
        let valorImpostoRenda = investmentSimulatorModel.investmentType != .LCI_LCA ? rendimentoBruto * (taxaImpostoRenda / 100) : 0
        let valorTotalLiquido = valorTotalBruto - valorImpostoRenda
        
        return InvestmentSimulatorDetailResultModel(investmentAmount: valorInvestido.formatAsCurrency(),
                                                    incomeValue: rendimentoBruto.formatAsCurrency(),
                                                    finalFull: valorTotalBruto.formatAsCurrency(),
                                                    discountIR: valorImpostoRenda.formatAsCurrency(),
                                                    finalValue: valorTotalLiquido.formatAsCurrency())
    }
    
    func investimentoPrefixadoCompleto(investimentoInicial: Double, investimentoMensal: Double, taxaJurosAnual: Double, prazoInvestimentoMensal: Double) -> Double {
        return investimentoPrefixado(investimentoInicial: investimentoInicial, taxaJurosAnual: taxaJurosAnual, prazoInvestimentoMensal: prazoInvestimentoMensal) + investimentoPrefixadoMensal(investimentoMensal: investimentoMensal, taxaJurosAnual: taxaJurosAnual, prazoInvestimentoMensal: prazoInvestimentoMensal - 1)
    }

    private func investimentoPrefixado(investimentoInicial: Double, taxaJurosAnual: Double, prazoInvestimentoMensal: Double) -> Double {
        let juros = taxaJurosAnual / 100
        let montante = investimentoInicial * pow((1 + juros), prazoInvestimentoMensal / 12)
        return montante
    }

    private func investimentoPrefixadoMensal(investimentoMensal: Double, taxaJurosAnual: Double, prazoInvestimentoMensal: Double) -> Double {
        
        if prazoInvestimentoMensal == 0 ||
            investimentoMensal == 0 {
            return investimentoMensal
        }
        
        if prazoInvestimentoMensal < 0 {
            return 0
        }
        
        let montante = investimentoPrefixado(investimentoInicial: investimentoMensal, taxaJurosAnual: taxaJurosAnual, prazoInvestimentoMensal: prazoInvestimentoMensal) + investimentoPrefixadoMensal(investimentoMensal: investimentoMensal, taxaJurosAnual: taxaJurosAnual, prazoInvestimentoMensal: prazoInvestimentoMensal - 1)
        return montante
    }
}
