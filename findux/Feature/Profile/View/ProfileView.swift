//
//  ProfileView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class ProfileView: BaseView<ProfileCoordinator> {
   
}

extension ProfileView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .green
    }
}

extension ProfileView: FullAccessViewControllerDelegate {
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToProfileTwoViewController))
    }
    
    @objc
    func goToProfileTwoViewController() {
        coordinatorDelegate?.goToProfileTwoViewController()
    }
}
