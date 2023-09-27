//
//  LoginError.swift
//  findux
//
//  Created by Péricles Narbal on 26/09/23.
//

import Foundation

enum LoginError: Error, CustomErrorProtocol {
    case invalidPassword(title: String, message: String)
    case dontHaveAccount(title: String, messsage: String)
    
    func getDescription() -> (title: String, message: String) {
        switch self {
        case .invalidPassword(let title, let message): return (title, message)
        case .dontHaveAccount(let title, let messsage): return (title, messsage)
        }
    }
}
