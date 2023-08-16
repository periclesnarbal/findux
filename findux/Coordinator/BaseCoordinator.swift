//
//  BaseCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

enum NavigationDirection {
    case forward
    case backward
}

class BaseCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [any ChildCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }
    
    func start() {}
    
    deinit {
        print("\(self)")
        print("DEINITITIALIZED \n")
    }
}

extension BaseCoordinator {
  
    func backToViewController<T: UIViewController>(_ viewController: T.Type) {
        do {
            try navigationController.backToViewControllerBy(type: viewController)
        } catch {
            print(error)
        }
    }
    
    func searchChildBy<T: ChildCoordinator>(type: T.Type) throws -> T {
        guard let foundChildCoordinator = childCoordinators.first(where: { $0.isKind(of: type) }) as? T else {
            throw NSError(domain: "Child coordinator is not found", code: 0)
        }
        return foundChildCoordinator
    }
    
    func goToChildCoordinator<T: ChildCoordinator>(_ child: T) {
        if let existingCoordinator = try? searchChildBy(type: T.self) {
            existingCoordinator.start()
            return
        }
        childCoordinators.append(child)
        child.start()
    }
    
    private func unstackViews(currentViewController: UIViewController, direction: NavigationDirection) {
        var controllerList: [UIViewController] = []
        for viewController in navigationController.viewControllers {
            let existsInNavigation = viewController.isKind(of: type(of: currentViewController))
            var addView = UIViewController()
            switch direction {
            case .forward:
                addView = existsInNavigation ? currentViewController : viewController
            case .backward:
                addView = viewController
            }
            controllerList.append(addView)
            if existsInNavigation { break }
        }
        navigationController.viewControllers = controllerList
    }
    
    private func updateChildCoordinators() {
        childCoordinators = childCoordinatorsInUse()
    }
    
    private func childCoordinatorsInUse() -> [any ChildCoordinator] {
        return navigationController.viewControllers
            .compactMap { ($0 as? (any ViewControllerDelegate))?.coordinator }
            .filter { coordinator in childCoordinators.contains { coordinator === $0 } }
    }
}


extension BaseCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let direction: NavigationDirection = navigationController.transitionCoordinator?.viewController(forKey: .from) != nil ? .backward : .forward
        unstackViews(currentViewController: viewController, direction: direction)
        
        updateChildCoordinators()
       
        print("--- \(self)")
        print("viewControllers \(navigationController.viewControllers)")
        print("childCoordinators \(childCoordinators)")
        
    }
}


