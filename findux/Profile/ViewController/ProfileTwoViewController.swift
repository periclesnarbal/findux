//
//  ProfileTwoViewController.swift
//  findux
//
//  Created by Péricles Narbal on 18/08/23.
//

import UIKit

final class ProfileTwoViewController: UIViewController, ViewControllerDelegate {
    
    weak var coordinator: ProfileCoordinator?
    weak var viewModel: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToMaterialViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
    }
    
    @objc
    func goToMaterialViewController() {
        coordinator?.goToMaterial()
    }
}
