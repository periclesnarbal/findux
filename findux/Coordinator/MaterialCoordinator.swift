//
//  MaterialCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

class MaterialCoordinator: BaseCoordinator, ChildCoordinator {
    unowned let parentCoordinator: MainCoordinator
    
    required init(parentCoordinator: MainCoordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        goToMaterialViewController()
    }
    
    func goToMaterialViewController() {
        let vc = MaterialViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToHome() {
        parentCoordinator.goToHomeCoordinator()
    }
    
}

