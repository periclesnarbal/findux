//
//  InvestmentDetailView.swift
//  findux
//
//  Created by Péricles Narbal on 21/11/23.
//

import UIKit
import SwiftUI

protocol InvestmentDetailViewProtocol: AnyObject {
    var viewModelDelegate: InvestmentDetailViewModelProtocol? { get set }
    
    func setupView(investmentSimulatorDetailModel: InvestmentSimulatorDetailModel)
    func setupView(investmentSimulatorDetailResultModel: InvestmentSimulatorDetailResultModel)
}

class InvestmentDetailView: BaseView<SimulatorCoordinator> {
    
    var viewModelDelegate: InvestmentDetailViewModelProtocol?
    
    @IBOutlet weak var investmentTypeLabel: UILabel!
    @IBOutlet weak var fixTypeLabel: UILabel!
    @IBOutlet weak var initialValueLabel: UILabel!
    @IBOutlet weak var montlyValueLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var profitRateLabel: UILabel!
    
    @IBOutlet weak var investmentAmountLabel: UILabel!
    @IBOutlet weak var incomeValueLabel: UILabel!
    @IBOutlet weak var finalFullLabel: UILabel!
    @IBOutlet weak var discountIRLabel: UILabel!
    @IBOutlet weak var finalValueLabel: UILabel!
    
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
    }
}

extension InvestmentDetailView: InvestmentDetailViewProtocol {
    func setupView(investmentSimulatorDetailModel: InvestmentSimulatorDetailModel) {
        investmentTypeLabel.text = investmentSimulatorDetailModel.investmentType
        fixTypeLabel.text = investmentSimulatorDetailModel.fixType
        initialValueLabel.text = investmentSimulatorDetailModel.initialValue
        montlyValueLabel.text = investmentSimulatorDetailModel.montlyValue
        termLabel.text = investmentSimulatorDetailModel.termValue
        profitRateLabel.text = investmentSimulatorDetailModel.profitRateValue
    }
    
    func setupView(investmentSimulatorDetailResultModel: InvestmentSimulatorDetailResultModel) {
        investmentAmountLabel.text = investmentSimulatorDetailResultModel.investmentAmount
        incomeValueLabel.text = investmentSimulatorDetailResultModel.incomeValue
        finalFullLabel.text = investmentSimulatorDetailResultModel.finalFull
        discountIRLabel.text = investmentSimulatorDetailResultModel.discountIR
        finalValueLabel.text = investmentSimulatorDetailResultModel.finalValue
    }
}

extension InvestmentDetailView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.title = "Resultado"
    }
}
