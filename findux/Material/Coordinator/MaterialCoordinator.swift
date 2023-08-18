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
    
    func goToMaterialTwoViewController() {
        let vc = MaterialTwoViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backToHome() {
        parentCoordinator.backToViewController(HomeViewController.self)
    }
}

