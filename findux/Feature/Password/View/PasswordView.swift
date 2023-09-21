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
    }
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var separatorView: SeparatorView!
    
    @IBOutlet weak var fieldStackView: UIStackView!
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    @IBOutlet weak var accountMessageLabel: UILabel!
    @IBOutlet weak var changeLoginButton: LinkButtonLabel!
    
    var signStatus: SignStatus = .sign_in {
        didSet { changeSignAction(status: signStatus) }
    }
    
    @IBAction func googleSignInButtonAction(_ sender: Any) {
        coordinatorDelegate?.handleGoogleSignIn()
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
    }
    
    private func fieldViewSetup(views: [UIView]) {
        views.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemGray5.cgColor
        }
    }
    
    private func showAllFields() {
        fieldStackView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.fieldStackView.arrangedSubviews.forEach {
                $0.isHidden = false
            }
        }, completion: { [weak self] finished in
            if finished {
                self?.fieldStackView.fadeInAnimation(duration: 0.4)
            }
        })
    }
    
    private func hideTaggedViews() {
        fieldStackView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.fieldStackView.arrangedSubviews.forEach {
                if $0.tag == 1 {
                    $0.isHidden = true
                }
            }
        }, completion: { [weak self] finished in
            if finished {
                self?.fieldStackView.fadeInAnimation(duration: 0.4)
            }
        })
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
