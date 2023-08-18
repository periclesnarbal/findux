//
//  MaterialTwoViewController.swift
//  findux
//
//  Created by Péricles Narbal on 18/08/23.
//

import UIKit

final class MaterialTwoViewController: UIViewController, ViewControllerDelegate {
    
    weak var coordinator: MaterialCoordinator?
    weak var viewModel: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToHomeViewController))
        // Do any additional setup after loading the view.
        view.backgroundColor = .magenta
    }
    
    @objc
    func goToHomeViewController() {
        coordinator?.backToHome()
    }
}
