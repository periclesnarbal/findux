//
//  HomeViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

class HomeCoordinator: BaseCoordinator, ChildCoordinator {
    unowned let parentCoordinator: MainCoordinator
    
    required init(parentCoordinator: MainCoordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        goToHomeViewController()
    }
    
    func goToHomeViewController() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToProfile() {
        parentCoordinator.goToProfileCoordinator()
    }
}
