//
//  UIViewExtension.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

extension UIView {
    func embedConstraints(_ view: UIView, padding: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
            view.topAnchor.constraint(equalTo: topAnchor, constant: padding.top),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.right),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom)
        ])
    }
}
