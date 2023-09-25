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
            let signInData = SignInModel(username: userTextField.text ?? "", password: passwordTextField.text ?? "")
            
            if let savedData: UserModel = UserDefaultsManager.shared.readItem(signInData.username) {
                if signInData.password == savedData.password {
                    print("PODE SEGUIR PARA PROXIMA PAGINA")
                } else {
                    print("Senha incorreta, por favor verifique seus dados e tente novamente")
                }
            } else {
                print("Este usúario não esta cadastrado. Para criar uma conta escolha a opção 'cadastra-se'")
            }
        }
    }
    
    func signUpAction() {
        if validateSignUpFields() {
            let signUpData = UserModel(username: userTextField.text ?? "", password: passwordTextField.text ?? "", email: emailTextField.text ?? "")
            UserDefaultsManager.shared.createItem(signUpData.username, value: signUpData)
            print("PODE SEGUIR PARA PROXIMA PAGINA")
        }
    }
    
    func validateSignInFields() -> Bool {
        guard let username = userTextField.text, let password = passwordTextField.text else { return false }
        
        return (!username.isEmpty && !password.isEmpty)
    }
    
    func validateSignUpFields() -> Bool {
      
        do {
            try fieldValidator.validateEmail(emailTextField.text)
            try fieldValidator.validateUsername(userTextField.text)
            try fieldValidator.validatePassword(passwordTextField.text)
            try fieldValidator.validatePasswordMatch(passwordTextField.text, checkPasswordTextField.text)
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
