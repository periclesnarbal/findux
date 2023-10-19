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
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding.top),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: padding.right),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom)
        ])
    }
    
    func loadViewFromNib(named: String? = nil) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = named == nil ? String(describing: type(of: self)) : named ?? ""
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return nibView
    }
    
    func addViewToBounds(_ view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        backgroundColor = view.backgroundColor
        addSubview(view)
    }

    func fadeInAnimation(duration: Double) {
        { [weak self] in
            self?.alpha = 0
            UIView.animate(withDuration: duration) {
                self?.alpha = 1
            }
        }()
    }
    
    func customFadeInAnimation(changeDuration: Double, appearDuration: Double, completion: (() -> Void)?) {
        { [weak self] in
            self?.alpha = 0
            UIView.animate(withDuration: changeDuration, animations: {
                completion?()
            }, completion: { finished in
                if finished {
                    self?.fadeInAnimation(duration: appearDuration)
                }
            })
        }()
    }
}
