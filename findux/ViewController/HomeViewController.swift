//
//  ViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class HomeViewController: UIViewController, ViewControllerDelegate {
    
    weak var coordinator: HomeCoordinator?
    weak var viewModel: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToProfileViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    @objc
    func goToProfileViewController() {
        coordinator?.goToProfile()
    }
    
    
    deinit {
        print("\(self)")
        print("DEINITITIALIZED \n")
    }
}

