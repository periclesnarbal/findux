//
//  ViewCoordinatorDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

protocol ViewCoordinatorDelegate: UIView {
    associatedtype CoordinatorType: ChildCoordinator
    
    var coordinatorDelegate: CoordinatorType? { get set }
}

