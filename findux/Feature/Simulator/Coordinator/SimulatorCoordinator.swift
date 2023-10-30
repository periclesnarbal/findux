//
//  SimulatorCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 30/10/23.
//

import UIKit

final class SimulatorCoordinator: BaseChildCoordinator<MainCoordinator> {
    typealias Closure = () -> Void
    
    func start(completion: Closure?) {
        goToSimulatorViewController(completion: completion)
    }
    
    func goToSimulatorViewController(completion: Closure?) {
        let vc = SimulatorViewController()
        let view = SimulatorView()
        vc.loadContentView(view)
        //        vc.lifeCycleDelegate = view
//        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
        
        completion?()
    }
}
