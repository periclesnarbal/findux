//
//  CoursesCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import UIKit

final class CoursesCoordinator: BaseChildCoordinator<HomeCoordinator> {
    typealias Closure = () -> Void
    
    func start(completion: Closure?) {
        goToCoursesViewController(completion: completion)
    }
    
    func goToCoursesViewController(completion: Closure?) {
        let vc = CoursesViewController()
        let view = CoursesView()
        vc.loadContentView(view)
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
        
        completion?()
    }
}

