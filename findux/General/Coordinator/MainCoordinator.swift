//
//  MainCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 29/06/23.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
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
    
    func goToPresentationCoordinator() {
        let presentationCoordinator = buildChildCoordinator(childType: PresentationCoordinator.self, parentCoordinator: self)
        presentationCoordinator.start()
    }
    
    func goToCoursesCoordinator() {
        let presentationCoordinator = buildChildCoordinator(childType: CoursesCoordinator.self, parentCoordinator: self)
        presentationCoordinator.start()
    }
}
