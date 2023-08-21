//
//  BaseChildCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 11/08/23.
//

import UIKit

class BaseChildCoordinator<T: BaseCoordinator>: BaseCoordinator, ChildCoordinator {
    unowned let parentCoordinator: T
    
    required init(parentCoordinator: T) {
        self.parentCoordinator = parentCoordinator
        super.init(navigationController: parentCoordinator.navigationController, navigationDelegate: parentCoordinator.navigationDelegate)
        navigationDelegate?.coordinatorDelegate = parentCoordinator
        navigationController.delegate = navigationDelegate
    }
}
