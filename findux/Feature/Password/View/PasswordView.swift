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
    @IBAction func googleSignInButtonAction(_ sender: Any) {
        coordinatorDelegate?.handleGoogleSignIn()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        let userData = UserModel(username: userTextField.text ?? "",
                                 password: passwordTextField.text ?? "",
                                 email: emailTextField.text ?? "")
        viewModelDelegate?.confirmButtonAction(user: userData, checkPassword: checkPasswordTextField.text ?? "")
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
            self.backgroundColor = view.backgroundColor
            addSubview(view)
        }
        
        fieldViewSetup(views: fieldStackView.arrangedSubviews)
        hideTaggedViews()
        
        changeLoginButton.action = { [weak self] in
            self?.viewModelDelegate?.signStatus.toggle()
        }
        
        separatorView.label.text = "Ou"
    }
    
    func changeTextItens(status: SignStatus) {
        confirmButton.setTitle(status.confirmButtonTitle(), for: .normal)
        accountMessageLabel.text = status.accountMessageDescription()
        changeLoginButton.text = status.loginButttonTitle()
    }
    
    func showAllFields() {
        fieldStackView.customFadeInAnimation(changeDuration: 0.3, appearDuration: 0.3) { [weak self] in
            self?.fieldStackView.arrangedSubviews.forEach {
                $0.isHidden = false
            }
        }
    }
    
    func hideTaggedViews() {
        fieldStackView.customFadeInAnimation(changeDuration: 0.3, appearDuration: 0.3) { [weak self] in
            self?.fieldStackView.arrangedSubviews.forEach {
                if $0.tag == 1 {
                    $0.isHidden = true
                }
            }
        }
    }
    
    func loginSuccess() {
        coordinatorDelegate?.goToHomeScreen()
    }
    
    func loginFailure(error: CustomErrorProtocol) {
        let error = error.getDescription()
        coordinatorDelegate?.showAlert(title: error.title, message: error.message)
    }

    private func fieldViewSetup(views: [UIView]) {
        views.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemGray5.cgColor
        }
    }
}

extension PasswordView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.isNavigationBarHidden = true
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
            let view = PasswordView()
            _ = PasswordViewModel(viewDelegate: view, userDefaults: UserDefaultsManager.shared, fieldValidator: FieldValidatorHelper())
            return view
        }.edgesIgnoringSafeArea(.all)
    }
}
