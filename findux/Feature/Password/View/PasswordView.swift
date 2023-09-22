//
//  PasswordView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit
import GoogleSignIn
import SwiftUI

class PasswordView: BaseView<PasswordCoordinator> {
    enum SignStatus {
        case sign_in
        case sign_up
        
        mutating func toggle() {
            switch self {
            case .sign_in: self = .sign_up
            case .sign_up: self = .sign_in
            }
        }
        
        func confirmButtonTitle() -> String {
            switch self {
            case .sign_in: return "Entrar"
            case .sign_up: return "Cadastrar"
            }
        }
        
        func accountMessageDescription() -> String {
            switch self {
            case .sign_in: return "Não possui uma conta?"
            case .sign_up: return "Já possui uma conta?"
            }
        }
        
        func loginButttonTitle() -> String {
            switch self {
            case .sign_in: return "Cadastre-se"
            case .sign_up: return "Entrar"
            }
        }
    }
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var separatorView: SeparatorView!
    
    @IBOutlet weak var fieldStackView: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    
    @IBOutlet weak var accountMessageLabel: UILabel!
    @IBOutlet weak var changeLoginButton: LinkButtonLabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var signStatus: SignStatus = .sign_in {
        didSet { changeSignAction(status: signStatus) }
    }
    
    let fieldValidator = FieldValidatorHelper()
    
    @IBAction func googleSignInButtonAction(_ sender: Any) {
        coordinatorDelegate?.handleGoogleSignIn()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        switch signStatus {
        case .sign_in: return signInAction()
        case .sign_up: return signUpAction()
        }
    }
    
    func signInAction() {
        if validateSignInFields() {
            print("PODE SEGUIR PARA PROXIMA PAGINA")
        }
    }
    
    func signUpAction() {
        if validateSignUpFields() {
            print("PODE SEGUIR PARA PROXIMA PAGINA")
        }
    }
    
    func validateSignInFields() -> Bool {
        do {
            try fieldValidator.validateUsername(userTextField.text ?? "")
            try fieldValidator.validatePassword(passwordTextField.text ?? "")
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    func validateSignUpFields() -> Bool {
      
        do {
            try fieldValidator.validateEmail(emailTextField.text ?? "")
            try fieldValidator.validateUsername(userTextField.text ?? "")
            try fieldValidator.validatePassword(passwordTextField.text ?? "")
            try fieldValidator.validatePasswordMatch(passwordTextField.text ?? "", checkPasswordTextField.text ?? "")
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        if let view: UIView = loadViewFromNib() {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true
            addSubview(view)
        }
        
        fieldViewSetup(views: fieldStackView.arrangedSubviews)
        hideTaggedViews()
        
        changeLoginButton.action = { [weak self] in
            self?.signStatus.toggle()
        }
        
        separatorView.label.text = "Ou"
    }
    
    private func changeSignAction(status: SignStatus) {
        switch status {
        case .sign_in: hideTaggedViews()
        case .sign_up: showAllFields()
        }
        
        changeTextItens(status: status)
    }
    
    private func changeTextItens(status: SignStatus) {
        confirmButton.setTitle(status.confirmButtonTitle(), for: .normal)
        accountMessageLabel.text = status.accountMessageDescription()
        changeLoginButton.text = status.loginButttonTitle()
    }
    
    private func fieldViewSetup(views: [UIView]) {
        views.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemGray5.cgColor
        }
    }
    
    private func showAllFields() {
        fieldStackView.customFadeInAnimation(changeDuration: 0.3, appearDuration: 0.3) { [weak self] in
            self?.fieldStackView.arrangedSubviews.forEach {
                $0.isHidden = false
            }
        }
    }
    
    private func hideTaggedViews() {
        fieldStackView.customFadeInAnimation(changeDuration: 0.3, appearDuration: 0.3) { [weak self] in
            self?.fieldStackView.arrangedSubviews.forEach {
                if $0.tag == 1 {
                    $0.isHidden = true
                }
            }
        }
    }
}

//extension PasswordView: LifeCycleViewControllerDelegate {
//    func loadView() {
//        if let view: UIView = loadViewFromNib() {
//            view.frame = bounds
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.translatesAutoresizingMaskIntoConstraints = true
//            addSubview(view)
//        }
//    }
//}

struct PasswordViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PasswordView()
        }.edgesIgnoringSafeArea(.all)
    }
}
