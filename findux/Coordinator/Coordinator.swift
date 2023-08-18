//
//  Coordinator.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

protocol Coordinator: NSObject {
    var childCoordinators: [any ChildCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    var navigationDelegate: CoordinatorNavigationControllerDelegate? { get set }
    
    func start()
}

protocol ChildCoordinator: Coordinator {
    associatedtype ParentCoordinatorType: Coordinator
    var parentCoordinator: ParentCoordinatorType { get }
    
    init(parentCoordinator: ParentCoordinatorType)
}
