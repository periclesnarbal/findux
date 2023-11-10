//
//  FinancingView.swift
//  findux
//
//  Created by Péricles Narbal on 10/11/23.
//

import UIKit
import SwiftUI

class FinancingView: BaseView<SimulatorCoordinator> {
    
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

extension FinancingView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.title = "Financiamento"
    }
}
