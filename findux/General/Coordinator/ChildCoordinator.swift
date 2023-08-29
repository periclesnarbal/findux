//
//  ChildCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import Foundation

protocol ChildCoordinator: Coordinator {
    associatedtype ParentCoordinatorType: Coordinator
    var parentCoordinator: ParentCoordinatorType { get }
    
    init(parentCoordinator: ParentCoordinatorType)
}
