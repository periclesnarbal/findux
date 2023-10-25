//
//  PasswordCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit
import GoogleSignIn

final class PasswordCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    let userDefaults = UserDefaultsManager.shared
    
    override func start() {
        goToPasswordViewController()
    }
    
    func goToPasswordViewController() {
        let vc = PasswordViewController()
        let view = PasswordView()
        let _ = PasswordViewModel(viewDelegate: view, userDefaults: userDefaults, fieldValidator: FieldValidatorHelper())
        vc.loadContentView(view)
        vc.fullAccessDelegate = view
        vc.lifeCycleDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHomeScreen() {
        parentCoordinator.goToHomeCoordinator()
    }
    
    func handleGoogleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: navigationController) { [weak self] signInResult, error in
            guard error == nil else { return }
            self?.goToHomeScreen()
        }
    }
}
