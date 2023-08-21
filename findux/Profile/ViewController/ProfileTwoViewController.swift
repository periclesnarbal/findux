//
//  ProfileTwoViewController.swift
//  findux
//
//  Created by Péricles Narbal on 18/08/23.
//

import UIKit

final class ProfileTwoViewController: UIViewController, ViewControllerCoordinatorDelegate {
    
    weak var coordinatorDelegate: ProfileCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToMaterialViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
    }
    
    @objc
    func goToMaterialViewController() {
        coordinatorDelegate?.goToMaterial()
    }
}
