//
//  HomeView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class HomeView: BaseView<HomeCoordinator> {
  
}

extension HomeView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .red
    }
}

extension HomeView: FullAccessViewControllerDelegate {
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToPasswordViewController))
    }
    
    @objc
    func goToHomeTwoViewController() {
        coordinatorDelegate?.goToHomeTwoViewController()
    }

    @objc
    func goToPasswordViewController() {
        coordinatorDelegate?.goToPassword()
    }
}
