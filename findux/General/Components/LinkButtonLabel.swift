//
//  LinkButtonLabel.swift
//  findux
//
//  Created by Péricles Narbal on 16/09/23.
//

import UIKit
import SwiftUI

class LinkButtonLabel: UILabel {
    let defaultSize: Double = 14
    let defaultColor: UIColor = .link
    
    var action: (() -> Void)?
    
    init(frame: CGRect = .zero, title: String, size: Double = 14, color: UIColor = .link, action: (() -> Void)?) {
        super.init(frame: frame)
        setupLabel(size: size, color: color)
        self.text = title
        self.action = action
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel(size: defaultSize,
                   color: defaultColor)
    }
    
    func setupLabel(size: Double, color: UIColor) {
        self.font = UIFont.systemFont(ofSize: size, weight: .semibold)
        self.textColor = color
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(linkButtonAction))
        self.addGestureRecognizer(tap)
    }
    
    @objc func linkButtonAction() {
        { [weak self] in
            self?.action?()
        }()
    }
}

struct LinkButtonLabelPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            LinkButtonLabel(title: "LINK") {
                print("LINK BUTTON")
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
