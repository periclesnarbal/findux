//
//  SecondViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class ProfileViewController: UIViewController, ViewControllerCoordinatorDelegate {
    
    weak var coordinatorDelegate: ProfileCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToProfileTwoViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
    }
    
    @objc
    func goToProfileTwoViewController() {
        coordinatorDelegate?.goToProfileTwoViewController()
    }
}

