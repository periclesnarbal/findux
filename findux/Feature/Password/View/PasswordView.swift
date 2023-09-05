//
//  PasswordView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class PasswordView: BaseView<PasswordCoordinator> {
 
}

extension PasswordView: LifeCycleViewControllerDelegate {
    func loadView() {
        if let view: UIView = loadViewFromNib() {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true
            addSubview(view)
        }
    }
}

