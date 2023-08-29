//
//  FullAccessViewControllerDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

protocol FullAccessViewControllerDelegate: NSObject {
    func getNavigationController(_ navigationController: UINavigationController?)
    func getNavigationItem(_ navigationItem: UINavigationItem)
    func getViewController(_ viewController: UIViewController)
}

extension FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        // Optional implementation
    }
    
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        // Optional implementation
    }
    
    func getViewController(_ viewController: UIViewController) {
        // Optional implementation
    }
}
