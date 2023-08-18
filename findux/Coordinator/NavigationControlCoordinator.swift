//
//  CoordinatorNavigationControllerDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 17/08/23.
//

import UIKit

enum NavigationDirection: String {
    case push = "PUSH"
    case pop = "POP"
    case idle = "IDLE"
}

protocol NavigationControlCoordinatorDelegate: NSObject, UINavigationControllerDelegate {
    var delegate: BaseCoordinatorNavigationControlDelegate? { get set }
}

final class NavigationControlCoordinator: NSObject, NavigationControlCoordinatorDelegate {
    
    weak var delegate: BaseCoordinatorNavigationControlDelegate?
    private var viewControllerCountBefore = 0
    var lastDirection: NavigationDirection = .idle
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        lastDirection = getNavigationDirection(navigationController: navigationController)
        
        print("DIRECTION: \(lastDirection.rawValue)")

        if lastDirection == .push {
            delegate?.unstackViews(currentViewController: viewController)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        viewControllerCountBefore = navigationController.viewControllers.count
        print("VIEW CONTROLLERS: \(navigationController.viewControllers)")
        if lastDirection == .pop {
            self.delegate?.updateChildCoordinators()
        }
    }
    
    private func getNavigationDirection(navigationController: UINavigationController) -> NavigationDirection {
        if navigationController.viewControllers.count > viewControllerCountBefore {
            return .push
        } else if navigationController.viewControllers.count < viewControllerCountBefore {
            return .pop
        }
        return .idle
    }
}
