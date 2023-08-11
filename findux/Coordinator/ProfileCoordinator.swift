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
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToMaterial() {
        parentCoordinator.goToMaterialCoordinator()
    }
}

