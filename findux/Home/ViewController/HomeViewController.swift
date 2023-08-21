//
//  ViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class HomeViewController: UIViewController, ViewControllerCoordinatorDelegate {
    
    weak var coordinatorDelegate: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToHomeTwoViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    @objc
    func goToHomeTwoViewController() {
        coordinatorDelegate?.goToHomeTwoViewController()
    }
}

