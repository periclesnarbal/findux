//
//  PasswordView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class PasswordView: BaseView<PasswordCoordinator> {
  
}

extension PasswordView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
        backgroundColor = .blue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let b = frame.height
        let c = frame.width
        let a = sqrt((pow(b, 2) + pow(c, 2)))
        let triangle = TriangleShape(a: a, b: b, c: c)
        layer.addSublayer(triangle)
        print(frame)
    }
}

