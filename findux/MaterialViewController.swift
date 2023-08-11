//
//  ThirdViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

class MaterialViewController: UIViewController, ViewControllerDelegate {
    
    weak var coordinator: MaterialCoordinator?
    weak var viewModel: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToHomeViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
    }
    
    @objc
    func goToHomeViewController() {
        coordinator?.goToHome()
    }
}

