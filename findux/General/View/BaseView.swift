//
//  BaseView.swift
//  findux
//
//  Created by Péricles Narbal on 28/08/23.
//

import UIKit

class BaseView<T: ChildCoordinator>: UIView, ViewCoordinatorDelegate {
    weak var coordinatorDelegate: T?
    
    deinit {
        print("\(self) DEINIT")
    }
}
