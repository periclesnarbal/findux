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
    
    var viewModelDelegate: PasswordViewModel?
   
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
    
    @IBAction func googleSignInButtonAction(_ sender: Any) {
        coordinatorDelegate?.handleGoogleSignIn()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        switch signStatus {
        case .sign_in: return signInAction(username: userTextField.text, password: passwordTextField.text)
        case .sign_up: return signUpAction(email: emailTextField.text, username: userTextField.text, password: passwordTextField.text, checkPassword: checkPasswordTextField.text)
        }
    }
    
    func signInAction(username: String?, password: String?) {
        viewModelDelegate?.signInAction(username: username, password: password)
    }
    
    func signUpAction(email: String?, username: String?, password: String?, checkPassword: String?) {
        viewModelDelegate?.signUpAction(email: email, username: username, password: password, checkPassword: checkPassword)
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
