//
//  BaseCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

protocol BaseCoordinatorStackControlDelegate: NSObject {
    func unstackViews(currentViewController: UIViewController)
    func updateChildCoordinators()
}

class BaseCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [any ChildCoordinator]()
    var navigationController: UINavigationController
    var navigationDelegate: CoordinatorNavigationControllerDelegate?
    
    init(navigationController: UINavigationController, navigationDelegate: CoordinatorNavigationControllerDelegate?) {
        self.navigationController = navigationController
        self.navigationDelegate = navigationDelegate
        super.init()
        navigationDelegate?.delegate = self
        navigationController.delegate = navigationDelegate
    }
    
    func start() {}
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
    
    func buildChildCoordinator<G: BaseCoordinator, T: BaseChildCoordinator<G>>(childType: T.Type, parentCoordinator: G) -> T {
        if let existingCoordinator = try? searchChildBy(type: childType) {
            return existingCoordinator
        }
        let child = T(parentCoordinator: parentCoordinator)
        childCoordinators.append(child)
        return child
    }
}

extension BaseCoordinator: BaseCoordinatorStackControlDelegate {
    func unstackViews(currentViewController: UIViewController) {
        var controllerList: [UIViewController] = []
        for viewController in navigationController.viewControllers {
            controllerList.append(viewController)
            if viewController.isKind(of: type(of: currentViewController)) {
                break
            }
        }
        navigationController.viewControllers = controllerList
    }
    
    func updateChildCoordinators() {
        childCoordinators = childCoordinatorsInUse()
    }
    
    private func childCoordinatorsInUse() -> [any ChildCoordinator] {
        // TODO: CONSERTAR ESTE METODO
        return navigationController.viewControllers
            .compactMap { ($0 as? (any ViewControllerDelegate))?.coordinator }
            .filter { coordinator in childCoordinators.contains { coordinator === $0 } }
    }
}


