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
        let view = ProfileView()
        vc.loadContentView(view)
        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToProfileTwoViewController() {
        let vc = ProfileTwoViewController()
        let view = ProfileTwoView()
        vc.loadContentView(view)
        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToMaterial() {
        parentCoordinator.goToMaterialCoordinator()
    }
}

