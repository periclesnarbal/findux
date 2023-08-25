//
//  PasswordCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

final class PasswordCoordinator: BaseChildCoordinator<MainCoordinator> {
    override func start() {
        goToPasswordViewController()
    }
    
    func goToPasswordViewController() {
        let vc = PasswordViewController()
        navigationController.present(vc, animated: true)
    }
}
