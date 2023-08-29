//
//  MaterialTwoView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class MaterialTwoView: BaseView<MaterialCoordinator> {
   
}

extension MaterialTwoView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .magenta
    }
}

extension MaterialTwoView: FullAccessViewControllerDelegate {
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToHomeViewController))
    }
    
    @objc
    func goToHomeViewController() {
        coordinatorDelegate?.backToHome()
    }
}
