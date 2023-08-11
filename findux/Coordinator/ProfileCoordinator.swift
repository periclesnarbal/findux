//
//  ProfileCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

class ProfileCoordinator: BaseCoordinator, ChildCoordinator {
    unowned let parentCoordinator: MainCoordinator
    
    required init(parentCoordinator: MainCoordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        goToProfileViewController()
    }
    
    func goToProfileViewController() {
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToMaterial() {
        parentCoordinator.goToMaterialCoordinator()
    }
}

