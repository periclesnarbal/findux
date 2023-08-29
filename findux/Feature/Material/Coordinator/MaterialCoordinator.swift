//
//  MaterialCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

final class MaterialCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    override func start() {
        goToMaterialViewController()
    }
    
    func goToMaterialViewController() {
        let vc = MaterialViewController()
        let view = MaterialView()
        vc.loadContentView(view)
        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToMaterialTwoViewController() {
        let vc = MaterialTwoViewController()
        let view = MaterialTwoView()
        vc.loadContentView(view)
        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHome() {
        parentCoordinator.goToHomeCoordinator()
    }
    
    func backToHome() {
        parentCoordinator.backToViewController(HomeViewController.self)
    }
}

