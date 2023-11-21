//
//  InvestmentView.swift
//  findux
//
//  Created by Péricles Narbal on 10/11/23.
//

import UIKit
import SwiftUI

class InvestmentView: BaseView<SimulatorCoordinator> {
    enum MonthYear: String {
        case month = "Mês"
        case year = "Ano"
        case invalid = ""
        
        init?(rawValue: String) {
            switch rawValue {
            case "Mês", "Meses": self = .month
            case "Ano", "Anos": self = .year
            default: self = .invalid
            }
        }
    }
    
    @IBOutlet weak var investingTypeSegment: UISegmentedControl!
    @IBOutlet weak var fixingTypeSegment: UISegmentedControl!
    @IBOutlet weak var termUnitSegment: UISegmentedControl!
    @IBOutlet weak var profitUnitSegment: UISegmentedControl!
    
    @IBOutlet weak var startInvestingAmountField: UITextField!
    @IBOutlet weak var monthlyInvestingField: UITextField!
    @IBOutlet weak var investingTermField: UITextField!
    @IBOutlet weak var profitRateField: UITextField!
    
    @IBOutlet var fieldArray: [UITextField]!
    
    @IBOutlet weak var continueButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        if let view: UIView = loadViewFromNib() {
            addViewToBounds(view)
        }
        
        startInvestingAmountField.addTarget(self, action: #selector(formatCurrencyTextInput(sender: )), for: .editingChanged)
        monthlyInvestingField.addTarget(self, action: #selector(formatCurrencyTextInput(sender: )), for: .editingChanged)
        
        termUnitSegment.addTarget(self, action: #selector(formatTermUnit(sender: )), for: .valueChanged)
        profitUnitSegment.addTarget(self, action: #selector(formatProfitUnit(sender: )), for: .valueChanged)
    }
    
    @objc func formatCurrencyTextInput(sender: UITextField) {
        let formatedEntry = sender.text?.fromDecimalCurrency()
        sender.text = formatedEntry?.toDecimalCurrency()
    }
    
    @objc func formatTermUnit(sender: UISegmentedControl) {
        var timeValue: Double = 0
        
        guard let field = investingTermField,
              let unit = getSegmentUnit(from: sender),
              let inputValue = field.text?.toDouble() else { return }
        
        switch unit {
        case .month: timeValue = yearsToMonths(from: inputValue)
        case .year: timeValue = monthsToYears(from: inputValue)
        case .invalid: return
        }
        
        let isInteger = timeValue.truncatingRemainder(dividingBy: 1) == 0
        let formatedResult = isInteger ? String(format: "%.0f", timeValue) : String(format: "%.2f", timeValue)
        
        field.text = formatedResult.replacingDotsForCommas()
    }
    
    @objc func formatProfitUnit(sender: UISegmentedControl) {
        var timeValue: Double = 0
        
        guard let field = profitRateField,
              let unit = getSegmentUnit(from: sender),
              let inputValue = field.text?.toDouble() else { return }
        
        switch unit {
        case .month: timeValue = monthsToYears(from: inputValue)
        case .year: timeValue = yearsToMonths(from: inputValue)
        case .invalid: return
        }
        
        field.text = String(timeValue).replacingDotsForCommas()
    }
    
    func getSegmentUnit(from segment: UISegmentedControl) -> MonthYear? {
        let selectedIndex = segment.selectedSegmentIndex
        if let title = segment.titleForSegment(at: selectedIndex) {
            return MonthYear(rawValue: title)
        }
       return nil
    }

    func yearsToMonths(from value: Double) -> Double {
        return value * 12
    }

    func monthsToYears(from value: Double) -> Double  {
        return value / 12
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        guard let termUnit = getSegmentUnit(from: termUnitSegment),
              let profitUnit = getSegmentUnit(from: profitUnitSegment),
              let investimentoInicial = startInvestingAmountField.text?.toDouble(),
              let investimentoMensal = monthlyInvestingField.text?.toDouble(),
              let taxaJuros = profitRateField.text?.toDouble(),
              let prazoInvestimento = investingTermField.text?.toDouble() else { return }
        
        let taxaJurosAnual = profitUnit == .year ? taxaJuros : taxaJuros * 12
        let prazoInvestimentoMensal = termUnit == .year ? prazoInvestimento * 12 : prazoInvestimento
        let result = investimentoPrefixadoCompleto(investimentoInicial: investimentoInicial, investimentoMensal: investimentoMensal, taxaJurosAnual: taxaJurosAnual, prazoInvestimentoMensal: prazoInvestimentoMensal)
        
        print(result)
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

extension InvestmentView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.title = "Investimento"
    }
}
