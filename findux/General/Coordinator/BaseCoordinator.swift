//
//  BaseCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

protocol BaseCoordinatorNavigationControlDelegate: NSObject {
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
        navigationDelegate?.coordinatorDelegate = self
        navigationController.delegate = navigationDelegate
    }
    
    func start() {}
    
    deinit {
        print("\(self) DEINIT")
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
    
    func buildChildCoordinator<G: BaseCoordinator, T: BaseChildCoordinator<G>>(childType: T.Type, parentCoordinator: G) -> T {
        if let existingCoordinator = try? searchChildBy(type: childType) {
            return existingCoordinator
        }
        let child = T(parentCoordinator: parentCoordinator)
        childCoordinators.append(child)
        return child
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completion?()
        }
        
        alertController.addAction(okAction)
        
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
    func showInWebView(url: String) {
        let vc = WebViewController()
        guard let url = URL(string: url) else { return }
        let webView = WebKitView(url: url)
        vc.loadContentView(webView)
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension BaseCoordinator: BaseCoordinatorNavigationControlDelegate {
    func unstackViews(currentViewController: UIViewController) {
        var controllerList: [UIViewController] = []
        for viewController in navigationController.viewControllers {
            controllerList.append(viewController)
            if viewController.isKind(of: type(of: currentViewController)) {
                break
            }
        }
        navigationController.viewControllers = controllerList
        print("CHILD COORDINATORS: \(childCoordinators)")
    }
    
    func updateChildCoordinators() {
        childCoordinators = childCoordinatorsInUse()
        print("UPDATE CHILD COORDINATORS: \(childCoordinators)")
    }
    
    private func childCoordinatorsInUse() -> [any ChildCoordinator] {
        let viewCoordinators = navigationController.viewControllers.compactMap { ($0 as? BaseViewController)?.coordinatorDelegate?() }
        return childCoordinators.filter { coordinator in viewCoordinators.contains { coordinator === $0 } }
    }
}


