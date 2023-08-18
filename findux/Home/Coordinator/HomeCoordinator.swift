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
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHomeTwoViewController() {
        let vc = HomeTwoViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfile() {
        parentCoordinator.goToProfileCoordinator()
    }
}
