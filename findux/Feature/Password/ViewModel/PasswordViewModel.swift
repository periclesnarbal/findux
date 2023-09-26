//
//  PasswordViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 26/09/23.
//

import Foundation

class PasswordViewModel {
    
    unowned var viewDelegate: PasswordView
    
    let userDefaults: UserDefaultsManager
    let fieldValidator: FieldValidatorHelper
    
    init(viewDelegate: PasswordView, userDefaults: UserDefaultsManager, fieldValidator: FieldValidatorHelper) {
        self.viewDelegate = viewDelegate
        self.userDefaults = userDefaults
        self.fieldValidator = fieldValidator
        
        self.viewDelegate.viewModelDelegate = self
    }
    
    var signStatus: SignStatus = .sign_in {
        didSet { changeSignAction(status: signStatus) }
    }
    
    func confirmButtonAction(user: UserModel, checkPassword: String) {
        switch signStatus {
        case .sign_in: return signInAction(username: user.username, password: user.password)
        case .sign_up: return signUpAction(email: user.email, username: user.username, password: user.password, checkPassword: checkPassword)
        }
    }
    
    func signInAction(username: String, password: String) {
        if validateSignInFields(username: username, password: password) {
            let loginData = LoginModel(username: username, password: password)
            
            if let savedData: UserModel = UserDefaultsManager.shared.readItem(loginData.username) {
                if loginData.password == savedData.password {
                    print("PODE SEGUIR PARA PROXIMA PAGINA")
                } else {
                    print("Senha incorreta, por favor verifique seus dados e tente novamente")
                }
            } else {
                print("Este usúario não esta cadastrado. Para criar uma conta escolha a opção 'cadastra-se'")
            }
        }
    }
    
    func signUpAction(email: String, username: String, password: String, checkPassword: String) {
        if validateSignUpFields(email: email, username: username, password: password, checkPassword: checkPassword) {
            let signUpData = UserModel(username: username, password: password, email: email)
            UserDefaultsManager.shared.createItem(signUpData.username, value: signUpData)
            print("PODE SEGUIR PARA PROXIMA PAGINA")
        }
    }
    
    func validateSignInFields(username: String?, password: String?) -> Bool {
        guard let username = username, let password = password else { return false }
        
        return (!username.isEmpty && !password.isEmpty)
    }
    
    func validateSignUpFields(email: String?, username: String?, password: String?, checkPassword: String?) -> Bool {
        do {
            try fieldValidator.validateEmail(email)
            try fieldValidator.validateUsername(username)
            try fieldValidator.validatePassword(password)
            try fieldValidator.validatePasswordMatch(password, checkPassword)
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    private func changeSignAction(status: SignStatus) {
        switch status {
        case .sign_in: viewDelegate.hideTaggedViews()
        case .sign_up: viewDelegate.showAllFields()
        }
        
        viewDelegate.changeTextItens(status: status)
    }
}
