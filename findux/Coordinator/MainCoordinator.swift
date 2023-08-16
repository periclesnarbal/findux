//
//  MainCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    override func start() {
        goToHomeCoordinator()
    }

    func goToHomeCoordinator() {
        var homeCoordinator = HomeCoordinator(parentCoordinator: self, navigationController: navigationController)
        goToChildCoordinator(homeCoordinator)
    }
    
    func goToProfileCoordinator() {
        let profileCoordinator = ProfileCoordinator(parentCoordinator: self, navigationController: navigationController)
        goToChildCoordinator(profileCoordinator)
    }
    
    func goToMaterialCoordinator() {
        let materialCoordinator = MaterialCoordinator(parentCoordinator: self, navigationController: navigationController)
        goToChildCoordinator(materialCoordinator)
    }
}
