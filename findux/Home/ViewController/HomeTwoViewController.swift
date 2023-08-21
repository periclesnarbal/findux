//
//  HomeTwoViewController.swift
//  findux
//
//  Created by Péricles Narbal on 18/08/23.
//

import UIKit

final class HomeTwoViewController: UIViewController, ViewControllerCoordinatorDelegate {
    
    weak var coordinatorDelegate: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToProfileViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkGray
    }
    
    @objc
    func goToProfileViewController() {
        coordinatorDelegate?.goToProfile()
    }
}
