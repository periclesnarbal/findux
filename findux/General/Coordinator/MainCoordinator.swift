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
        let homeCoordinator = buildChildCoordinator(childType: HomeCoordinator.self, parentCoordinator: self)
        homeCoordinator.start()
    }
    
    func goToProfileCoordinator() {
        let profileCoordinator =  buildChildCoordinator(childType: ProfileCoordinator.self, parentCoordinator: self)
        profileCoordinator.start()
    }
    
    func goToMaterialCoordinator() {
        let materialCoordinator =  buildChildCoordinator(childType: MaterialCoordinator.self, parentCoordinator: self)
        materialCoordinator.start()
    }
    
    func goToPasswordCoordinator() {
        let passwordCoordinator = buildChildCoordinator(childType: PasswordCoordinator.self, parentCoordinator: self)
        passwordCoordinator.start()
    }
}
