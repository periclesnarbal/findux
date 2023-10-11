//
//  PresentationCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 02/10/23.
//

import UIKit

final class PresentationCoordinator: BaseChildCoordinator<MainCoordinator> {
    let userDefaults = UserDefaultsManager.shared
    
    override func start() {
        goToPresentationViewController()
    }
    
    func goToPresentationViewController() {
        let vc = PresentationViewController()
        let view = PresentationView()
        _ = PresentationCourseViewModel(viewDelegate: view, userDefaults: userDefaults)
        vc.loadContentView(view)
        view.coordinatorDelegate = self
        navigationController.present(vc, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

