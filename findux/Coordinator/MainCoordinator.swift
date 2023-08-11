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
        var child = HomeCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        if let currentChild = try? searchChildBy(type: HomeCoordinator.self) {
            child = currentChild
        } else {
            childCoordinators.append(child)
        }
        
        child.start()
    }
    
    func goToProfileCoordinator() {
        var child = ProfileCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        if let currentChild = try? searchChildBy(type: ProfileCoordinator.self) {
            child = currentChild
        } else {
            childCoordinators.append(child)
        }
        
        child.start()
    }
    
    func goToMaterialCoordinator() {
        var child = MaterialCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        if let currentChild = try? searchChildBy(type: MaterialCoordinator.self) {
            child = currentChild
        } else {
            childCoordinators.append(child)
        }
        
        child.start()
    }
}
