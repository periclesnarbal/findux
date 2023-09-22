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
    }
    
    func validateEmail(_ email: String) throws {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        do {
            try handleBlankSpaces(email, title: "Erro", message: "O email não deve conter espaços")
            try handleEmptyField(email, title: "Erro", message: "O preenchimento do campo de 'email' é obrigatório")
        } catch {
            throw error
        }
        
        if !emailTest.evaluate(with: email) {
            throw fieldError.invalidEmail(title: "Erro", message: "O formato de email é invalido. Verifique se os dados foram inseridos corretamente")
        }
    }
    
    func validateUsername(_ username: String) throws {
        
        do {
            try handleBlankSpaces(username, title: "Erro", message: "O nome de usuário não deve conter espaços")
            try handleEmptyField(username, title: "Erro", message: "O preenchimento do campo 'usuário' é obrigatório")
        } catch {
            throw error
        }
        
        if (username.count < 3) || (username.count > 20) {
            throw fieldError.invalidLenth(title: "Erro", message: "O nome de usuário deve ter entre 3 e 20 caracteres")
        }
        
    }
    
    func validatePassword(_ password: String) throws {
        
        do {
            try handleBlankSpaces(password, title: "Erro", message: "A senha não deve conter espaços")
            try handleEmptyField(password, title: "Erro", message: "O preenchimento do campo de 'senha' é obrigatório")
        } catch {
            throw error
        }
       
        if password.count < 8 {
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
    
    func validatePasswordMatch(_ password1: String, _ password2: String) throws {
        if password1 != password2 {
            throw fieldError.mustBeEqual(title: "Erro", message: "As senhas fornecidas não conferem. Verfique se as senhas fornecidas são iguais")
        }
    }
    
    func handleBlankSpaces(_ string: String, title: String, message: String) throws {
        if string.contains(" ") {
            throw fieldError.invalidLenth(title: title, message: message)
        }
    }
    
    func handleEmptyField(_ string: String, title: String, message: String) throws {
        if string.isEmpty {
            throw fieldError.emptyField(title: title, message: message)
        }
    }
}
