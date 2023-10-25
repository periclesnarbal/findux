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
    let keychain: KeychainManager = KeychainManager.shared
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
        do {
            switch signStatus {
            case .sign_in: return try signInAction(user: user)
            case .sign_up: return signUpAction(user: user, checkPassword: checkPassword)
            }
        } catch {
            if let error = error as? CustomErrorProtocol {
                viewDelegate.loginFailure(error: error)
            }
        }
    }
    
    func signInAction(user: UserModel) throws {
        if validateSignInFields(username: user.username, password: user.password) {
            if let userProfile: UserProfile = userDefaults.readItem(user.username) {
                let savedPassword = keychain.retrieveInfo(forKey: userProfile.username)
                if user.password == savedPassword {
                    loginSuccess(user: userProfile)
                } else {
                    throw LoginError.invalidPassword(title: "Erro", message: "Senha incorreta, por favor verifique seus dados e tente novamente")
                }
            } else {
                throw LoginError.dontHaveAccount(title: "Erro", messsage: "Este usúario não esta cadastrado. Para criar uma conta escolha a opção 'cadastra-se'")
            }
        }
    }
    
    func signUpAction(user: UserModel, checkPassword: String) {
        if validateSignUpFields(user: user, checkPassword: checkPassword) {
            keychain.saveInfo(forKey: user.username, info: user.password)
            let userProfile = UserProfile(username: user.username, email: user.email)
            userDefaults.createItem(userProfile.username, value: userProfile)
            loginSuccess(user: userProfile)
        }
    }
    
    private func loginSuccess(user: UserProfile) {
        UserGIDProfile.shared.manualInsert(user: user)
        viewDelegate.loginSuccess()
    }
    
    func validateSignInFields(username: String?, password: String?) -> Bool {
        guard let username = username, let password = password else { return false }
        
        return (!username.isEmpty && !password.isEmpty)
    }
    
    func validateSignUpFields(user: UserModel, checkPassword: String?) -> Bool {
        do {
            try fieldValidator.validateEmail(user.email)
            try fieldValidator.validateUsername(user.username)
            try fieldValidator.validatePassword(user.password)
            try fieldValidator.validatePasswordMatch(user.password, checkPassword)
        } catch {
            if let error = error as? CustomErrorProtocol {
                viewDelegate.loginFailure(error: error)
            }
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
