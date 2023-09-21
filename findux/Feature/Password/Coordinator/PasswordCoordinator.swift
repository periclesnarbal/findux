//
//  PasswordCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit
import GoogleSignIn

final class PasswordCoordinator: BaseChildCoordinator<MainCoordinator> {
    
    override func start() {
        goToPasswordViewController()
    }
    
    func goToPasswordViewController() {
        let vc = PasswordViewController()
        let view = PasswordView()
        vc.loadContentView(view)
//        vc.lifeCycleDelegate = view
        view.coordinatorDelegate = self
        navigationController.present(vc, animated: true)
    }
    
    func handleGoogleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: navigationController) { signInResult, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
            print("SIGN IN SUCCEDED")
          }
    }
}
