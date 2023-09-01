//
//  PasswordView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class PasswordView: BaseView<PasswordCoordinator> {
    var triangle: TriangleRectangleShape?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if triangle == nil {
            let triangle = TriangleRectangleShape(b: frame.height, c: frame.width)
            triangle.fillColor = UIColor.white.cgColor
            self.triangle = triangle
            layer.addSublayer(triangle)
        }
    }
}

extension PasswordView: LifeCycleViewControllerDelegate {
    func viewDidLoad() {
//        backgroundColor = .blue
    }
    
    
}

