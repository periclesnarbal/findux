//
//  CoursesCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import UIKit

final class CoursesCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    override func start() {
        goToCoursesViewController()
    }
    
    func goToCoursesViewController() {
        let vc = CoursesViewController()
        let view = CoursesView()
        vc.loadContentView(view)
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
        
        goToPresent()
    }
    
    func goToPresent() {
        parentCoordinator.goToPresentationCoordinator()
    }
}

