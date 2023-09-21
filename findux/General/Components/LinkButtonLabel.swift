//
//  LinkButtonLabel.swift
//  findux
//
//  Created by Péricles Narbal on 16/09/23.
//

import UIKit
import SwiftUI

class LinkButtonLabel: UILabel {
    static let defaultSize: Double = 14
    static let defaultColor: UIColor = .link
    
    var action: (() -> Void)?
    
    init(frame: CGRect = .zero, title: String, size: Double = defaultSize, color: UIColor = defaultColor, action: (() -> Void)?) {
        super.init(frame: frame)
        setupLabel(size: size, color: color)
        self.text = title
        self.action = action
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel(size: LinkButtonLabel.defaultSize,
                   color: LinkButtonLabel.defaultColor)
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
