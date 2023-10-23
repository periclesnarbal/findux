//
//  PresentationCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 02/10/23.
//

import UIKit

final class PresentationCoordinator: BaseChildCoordinator<MainCoordinator> {
    let userDefaults = UserDefaultsManager.shared
    
    func start(presentationModel: PresentationModel) {
        goToPresentationViewController(presentationModel: presentationModel)
    }
    
    func goToPresentationViewController(presentationModel: PresentationModel) {
        let vc = PresentationViewController()
        let view = PresentationView()
        _ = PresentationViewModel(viewDelegate: view, userDefaults: userDefaults, presentationModel: presentationModel)
        vc.loadContentView(view)
        view.coordinatorDelegate = self
        navigationController.present(vc, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

