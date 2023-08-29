//
//  ProfileTwoView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class ProfileTwoView: BaseView<ProfileCoordinator> {
  
}

extension ProfileTwoView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .yellow
    }
}

extension ProfileTwoView: FullAccessViewControllerDelegate {
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToMaterialViewController))
    }
    
    @objc
    func goToMaterialViewController() {
        coordinatorDelegate?.goToMaterial()
    }
}
