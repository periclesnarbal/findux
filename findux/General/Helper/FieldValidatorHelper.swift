//
//  FieldValidatorHelper.swift
//  findux
//
//  Created by Péricles Narbal on 22/09/23.
//

import Foundation

struct FieldValidatorHelper {
    enum fieldError: Error {
        case invalidEmail(title: String, message: String)
        case invalidLenth(title: String, message: String)
        case emptyField(title: String, message: String)
        case containsWhitespace(title: String, message: String)
        case mustContainCapitalLetter(title: String, message: String)
        case mustContainNumber(title: String, message: String)
        case mustBeEqual(title: String, message: String)
        case nilValue(title: String, message: String)
    }
    
    func validateEmail(_ email: String?) throws {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        do {
            try handleBlankSpaces(email, errorTitle: "Erro", errorMessage: "O email não deve conter espaços")
            try handleEmptyField(email, errorTitle: "Erro", errorMessage: "O preenchimento do campo de 'email' é obrigatório")
        } catch {
            throw error
        }
        
        if !emailTest.evaluate(with: email) {
            throw fieldError.invalidEmail(title: "Erro", message: "O formato de email é invalido. Verifique se os dados foram inseridos corretamente")
        }
    }
    
    func validateUsername(_ username: String?) throws {
        
        do {
            try handleBlankSpaces(username, errorTitle: "Erro", errorMessage: "O nome de usuário não deve conter espaços")
            try handleEmptyField(username, errorTitle: "Erro", errorMessage: "O preenchimento do campo 'usuário' é obrigatório")
        } catch {
            throw error
        }
        
        if ((username?.count ?? 0) < 3) || ((username?.count ?? 0) > 20) {
            throw fieldError.invalidLenth(title: "Erro", message: "O nome de usuário deve ter entre 3 e 20 caracteres")
        }
    }
    
    func validatePassword(_ password: String?) throws {
        
        do {
            try handleBlankSpaces(password, errorTitle: "Erro", errorMessage: "A senha não deve conter espaços")
            try handleEmptyField(password, errorTitle: "Erro", errorMessage: "O preenchimento do campo de 'senha' é obrigatório")
        } catch {
            throw error
        }
       
        if (password?.count ?? 0) < 8 {
            throw fieldError.invalidLenth(title: "Erro", message: "A senha deve conter no mínimo 8 caracteres")
        }
        
        let letraMaiusculaPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        let numeroPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        
        if !letraMaiusculaPredicate.evaluate(with: password) {
            throw fieldError.mustContainCapitalLetter(title: "Erro", message: "A senha deve conter pelo menos uma letra maiúscula")
        }
        
        if !numeroPredicate.evaluate(with: password) {
            throw fieldError.mustContainNumber(title: "Erro", message: "A senha deve conter pelo menos um número")
        }
    }
    
    func validatePasswordMatch(_ password1: String?, _ password2: String?) throws {
        do {
            try checkFieldMatch(password1, password2, errorTitle: "Erro", errorMessage: "As senhas fornecidas não conferem. Verfique se as senhas fornecidas são iguais")
        } catch {
            throw error
        }
    }
    
    func checkFieldMatch(_ field1: String?, _ field2: String?, errorTitle: String, errorMessage: String) throws {
        guard let field1 = field1, let field2 = field2 else { throw fieldError.nilValue(title: errorTitle, message: errorMessage) }
        
        if field1 != field2 {
            throw fieldError.mustBeEqual(title: errorTitle, message: errorMessage)
        }
    }
    
    func handleBlankSpaces(_ string: String?, errorTitle: String, errorMessage: String) throws {
        guard let string = string else { throw fieldError.nilValue(title: errorTitle, message: errorMessage) }
        
        if string.contains(" ") {
            throw fieldError.containsWhitespace(title: errorTitle, message: errorMessage)
        }
    }
    
    func handleEmptyField(_ string: String?, errorTitle: String, errorMessage: String) throws {
        guard let string = string else { throw fieldError.nilValue(title: errorTitle, message: errorMessage) }
        
        if string.isEmpty {
            throw fieldError.emptyField(title: errorTitle, message: errorMessage)
        }
    }
}
