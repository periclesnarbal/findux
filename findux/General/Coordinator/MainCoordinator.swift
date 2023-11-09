//
//  MainCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    typealias Closure = () -> Void
    
    override func start() {
        goToPasswordCoordinator()
    }

    func goToHomeCoordinator() {
        let homeCoordinator = buildChildCoordinator(childType: HomeCoordinator.self, parentCoordinator: self)
        homeCoordinator.start()
    }
    
    func goToPasswordCoordinator() {
        let passwordCoordinator = buildChildCoordinator(childType: PasswordCoordinator.self, parentCoordinator: self)
        passwordCoordinator.start()
    }
    
    func goToPresentationCoordinator(presentationModel: PresentationModel) {
        let presentationCoordinator = buildChildCoordinator(childType: PresentationCoordinator.self, parentCoordinator: self)
        presentationCoordinator.start(presentationModel: presentationModel)
    }
}
