//
//  MaterialView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class MaterialView: BaseView<MaterialCoordinator> {
   
}

extension MaterialView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .orange
    }
}

extension MaterialView: FullAccessViewControllerDelegate {
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToMaterialTwoViewController))
    }
    
    @objc
    func goToMaterialTwoViewController() {
        coordinatorDelegate?.goToMaterialTwoViewController()
    }
}
