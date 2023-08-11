//
//  SecondViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class ProfileViewController: UIViewController, ViewControllerDelegate {
    
    weak var coordinator: ProfileCoordinator?
    weak var viewModel: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToMaterialViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
    }
    
    @objc
    func goToMaterialViewController() {
        coordinator?.goToMaterial()
    }
    
    
    deinit {
        print("\(self)")
        print("DEINITITIALIZED \n")
    }
}

