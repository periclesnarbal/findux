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
        let view = HomeView()
        vc.loadContentView(view)
//        vc.lifeCycleDelegate = view
//        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHomeTwoViewController() {
        let vc = HomeTwoViewController()
        let view = HomeTwoView()
        vc.loadContentView(view)
        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfile() {
        parentCoordinator.goToProfileCoordinator()
    }
    
    func goToPassword() {
        parentCoordinator.goToPasswordCoordinator()
    }
}
