//
//  HomeTwo.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class HomeTwoView: BaseView<HomeCoordinator> {
   
}

extension HomeTwoView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .darkGray
    }
}

extension HomeTwoView: FullAccessViewControllerDelegate {
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToProfileViewController))
    }
    
    @objc
    func goToProfileViewController() {
        coordinatorDelegate?.goToProfile()
    }
}
