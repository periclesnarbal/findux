//
//  PresentationCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 02/10/23.
//

import UIKit

final class PresentationCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    override func start() {
        goToPresentationViewController()
    }
    
    func goToPresentationViewController() {
        let vc = PresentationViewController()
        let view = PresentationView()
//        let _ = PresentationView(viewDelegate: view, userDefaults: UserDefaultsManager.shared, fieldValidator: FieldValidatorHelper())
        vc.loadContentView(view)
//        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

