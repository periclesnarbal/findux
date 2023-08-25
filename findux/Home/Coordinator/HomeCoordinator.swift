//
//  HomeViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class HomeCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    override func start() {
        goToHomeViewController()
    }
    
    func goToHomeViewController() {
        let vc = HomeViewController()
        vc.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHomeTwoViewController() {
        let vc = HomeTwoViewController()
        vc.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfile() {
        parentCoordinator.goToProfileCoordinator()
    }
    
    func goToPassword() {
        parentCoordinator.goToPasswordCoordinator()
    }
}
