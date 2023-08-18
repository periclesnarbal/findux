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
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHome() {
        parentCoordinator.goToHomeCoordinator()
    }
    
    func backToHome() {
        parentCoordinator.backToViewController(HomeViewController.self)
    }
}

