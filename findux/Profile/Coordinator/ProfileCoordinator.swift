//
//  ProfileCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

final class ProfileCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    override func start() {
        goToProfileViewController()
    }
    
    func goToProfileViewController() {
        let vc = ProfileViewController()
        vc.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfileTwoViewController() {
        let vc = ProfileTwoViewController()
        vc.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToMaterial() {
        parentCoordinator.goToMaterialCoordinator()
    }
}

