//
//  InvestmentView.swift
//  findux
//
//  Created by Péricles Narbal on 10/11/23.
//

import UIKit
import SwiftUI

class InvestmentView: BaseView<SimulatorCoordinator> {
    let IPCA = 4.82
    let CDI = 12.15
    
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
        
        fixingTypeSegment.addTarget(self, action: #selector(fixingTypeSegmentAction(sender: )), for: .valueChanged)
        termUnitSegment.addTarget(self, action: #selector(formatTermUnit(sender: )), for: .valueChanged)
        profitUnitSegment.addTarget(self, action: #selector(formatProfitUnit(sender: )), for: .valueChanged)
    }
    
    @objc func fixingTypeSegmentAction(sender: UISegmentedControl) {
        let fixType = InvestmentFixType(rawValue: sender.getTitle())
        switch fixType {
        case .CDI, .IPCA:
            profitUnitSegment.selectedSegmentIndex = 0
            profitUnitSegment.isEnabled = false
        case .PRE:
            profitUnitSegment.isEnabled = true
        }
    }
    
    @objc func formatCurrencyTextInput(sender: UITextField) {
        let formatedEntry = sender.text?.fromDecimalCurrency()
        sender.text = formatedEntry?.toDecimalCurrency()
    }
    
    @objc func formatTermUnit(sender: UISegmentedControl) {
        var timeValue: Double = 0
        let unit = MonthYear(rawValue: sender.getTitle())
        
        guard let field = investingTermField,
              let inputValue = field.text?.toDouble() else { return }
        
        timeValue = unit == .month ? yearsToMonths(from: inputValue) : monthsToYears(from: inputValue)
        let formatedResult = timeValue.toStringIntOrDecimal()
        
        field.text = formatedResult.replacingDotsForCommas()
    }
    
    @objc func formatProfitUnit(sender: UISegmentedControl) {
        var timeValue: Double = 0
        let unit = MonthYear(rawValue: sender.getTitle())
        guard let field = profitRateField,
              let inputValue = field.text?.toDouble() else { return }
        
        timeValue = unit == .month ? monthsToYears(from: inputValue) : yearsToMonths(from: inputValue)
        
        field.text = String(timeValue).replacingDotsForCommas()
    }

    func yearsToMonths(from value: Double) -> Double {
        return value * 12
    }

    func monthsToYears(from value: Double) -> Double  {
        return value / 12
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let investmentType = InvestmentType(rawValue: investingTypeSegment.getTitle())
        let fixType = InvestmentFixType(rawValue: fixingTypeSegment.getTitle())
        let termUnit = MonthYear(rawValue: termUnitSegment.getTitle())
        let profitUnit = MonthYear(rawValue: profitUnitSegment.getTitle())
        
        guard let investimentoInicial = startInvestingAmountField.text?.toDouble(),
              let investimentoMensal = monthlyInvestingField.text?.toDouble(),
              var taxaJuros = profitRateField.text?.toDouble(),
              let prazoInvestimento = investingTermField.text?.toDouble()
        else {
            coordinatorDelegate?.showAlert(title: "Aviso", message: "Preencha todos os campos antes de prosseguir com a simulação.")
            return
        }
        
        switch fixType {
        case .CDI:
            taxaJuros = calculateCDI(profitRate: taxaJuros)
        case .IPCA:
            taxaJuros = IPCA + taxaJuros
        case .PRE:
            break
        }
        
        let investmentSimulatorModel = InvestmentSimulatorModel(investmentType: investmentType, fixType: fixType, termType: termUnit, profitRateType: profitUnit, initialValue: investimentoInicial, montlyValue: investimentoMensal, termValue: prazoInvestimento, profitRateValue: taxaJuros)
        
        coordinatorDelegate?.goToInvestimentDetail(investmentSimulatorModel: investmentSimulatorModel)
    }
    
    func calculateCDI(profitRate: Double) -> Double {
        return (CDI * profitRate) / 100
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
