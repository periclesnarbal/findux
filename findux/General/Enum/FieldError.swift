//
//  FieldError.swift
//  findux
//
//  Created by Péricles Narbal on 27/09/23.
//

import Foundation

enum FieldError: Error, CustomErrorProtocol {
    case invalidEmail(title: String, message: String)
    case invalidLenth(title: String, message: String)
    case emptyField(title: String, message: String)
    case containsWhitespace(title: String, message: String)
    case mustContainCapitalLetter(title: String, message: String)
    case mustContainNumber(title: String, message: String)
    case mustBeEqual(title: String, message: String)
    case nilValue(title: String, message: String)
    
    func getDescription() -> (title: String, message: String) {
        switch self {
        case .invalidEmail(let title, let message): return (title, message)
        case .invalidLenth(let title, let message): return (title, message)
        case .emptyField(let title, let message): return (title, message)
        case .containsWhitespace(let title, let message): return (title, message)
        case .mustContainCapitalLetter(let title, let message): return (title, message)
        case .mustContainNumber(let title, let message): return (title, message)
        case .mustBeEqual(let title, let message): return (title, message)
        case .nilValue(let title, let message): return (title, message)
        }
    }
}
