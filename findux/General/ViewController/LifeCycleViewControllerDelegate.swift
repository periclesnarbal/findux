//
//  LifeCycleViewControllerDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

protocol LifeCycleViewControllerDelegate: NSObject {
    func loadView()
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillLayoutSubviews()
    func viewDidLayoutSubviews()
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

extension LifeCycleViewControllerDelegate {
    func loadView() {
        // Optional implementation
    }

    func viewDidLoad() {
        // Optional implementation
    }

    func viewWillAppear(_ animated: Bool) {
        // Optional implementation
    }

    func viewWillLayoutSubviews() {
        // Optional implementation
    }

    func viewDidLayoutSubviews() {
        // Optional implementation
    }

    func viewDidAppear(_ animated: Bool) {
        // Optional implementation
    }

    func viewWillDisappear(_ animated: Bool) {
        // Optional implementation
    }

    func viewDidDisappear(_ animated: Bool) {
        // Optional implementation
    }
}

