//
//  SignStatus.swift
//  findux
//
//  Created by Péricles Narbal on 25/09/23.
//

import Foundation

enum SignStatus {
    case sign_in
    case sign_up
    
    mutating func toggle() {
        switch self {
        case .sign_in: self = .sign_up
        case .sign_up: self = .sign_in
        }
    }
    
    func confirmButtonTitle() -> String {
        switch self {
        case .sign_in: return "Entrar"
        case .sign_up: return "Cadastrar"
        }
    }
    
    func accountMessageDescription() -> String {
        switch self {
        case .sign_in: return "Não possui uma conta?"
        case .sign_up: return "Já possui uma conta?"
        }
    }
    
    func loginButttonTitle() -> String {
        switch self {
        case .sign_in: return "Cadastre-se"
        case .sign_up: return "Entrar"
        }
    }
}
