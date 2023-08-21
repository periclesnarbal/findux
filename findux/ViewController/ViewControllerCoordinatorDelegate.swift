//
//  ViewControllerDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import Foundation

protocol ViewControllerCoordinatorDelegate {
    associatedtype CoordinatorType: ChildCoordinator
    
    var coordinatorDelegate: CoordinatorType? { get set }
}

