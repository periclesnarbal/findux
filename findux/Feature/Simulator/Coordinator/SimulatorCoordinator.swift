//
//  SimulatorCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 30/10/23.
//

import UIKit

final class SimulatorCoordinator: BaseChildCoordinator<HomeCoordinator> {
    typealias Closure = () -> Void
    
    override func start() {
        goToSimulatorViewController()
    }
    
    func goToSimulatorViewController() {
        let vc = SimulatorViewController()
        let view = SimulatorView()
        vc.loadContentView(view)
        //        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}
