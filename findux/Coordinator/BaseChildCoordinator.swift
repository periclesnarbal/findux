//
//  BaseChildCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 11/08/23.
//

import UIKit

class BaseChildCoordinator<T: BaseCoordinator>: BaseCoordinator, ChildCoordinator {
    unowned let parentCoordinator: T
    
    required init(parentCoordinator: T, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        super.init(navigationController: navigationController)
        navigationController.delegate = parentCoordinator
    }
}
