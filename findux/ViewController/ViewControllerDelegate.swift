//
//  ViewControllerDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import Foundation

protocol ViewControllerDelegate {
    associatedtype CoordinatorType: ChildCoordinator
    associatedtype ViewModelType
    
    var coordinator: CoordinatorType? { get set }
    var viewModel: ViewModelType? { get set }
}

