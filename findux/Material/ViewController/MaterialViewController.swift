//
//  ThirdViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class MaterialViewController: UIViewController, ViewControllerCoordinatorDelegate {
    
    weak var coordinatorDelegate: MaterialCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToMaterialTwoViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
    }
    
    @objc
    func goToMaterialTwoViewController() {
        coordinatorDelegate?.goToMaterialTwoViewController()
    }
}

