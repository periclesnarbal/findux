//
//  PasswordTextField.swift
//  findux
//
//  Created by Péricles Narbal on 13/09/23.
//

import UIKit
import SwiftUI

class PasswordTextField: UITextField {
    
    let eyeButton: EyeButton = EyeButton(action: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    private func commomInit() {
        eyeButton.action = eyeButtonAction(status:)
        borderStyle = .roundedRect
        placeholder = "Senha"
        
        rightView = eyeButton
        rightViewMode = .always
    }
    
    func eyeButtonAction(status: EyeButton.Status) {
        { [weak self] in
            switch status {
            case .opened: self?.isSecureTextEntry = false
            case .closed: self?.isSecureTextEntry = true
            }
        }()
    }
}

struct PasswordTextFieldPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PasswordTextField()
        }.edgesIgnoringSafeArea(.all)
    }
}
