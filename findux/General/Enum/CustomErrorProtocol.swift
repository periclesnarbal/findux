//
//  CustomErrorProtocol.swift
//  findux
//
//  Created by Péricles Narbal on 27/09/23.
//

import Foundation

protocol CustomErrorProtocol: Error {
    func getDescription() -> (title: String, message: String)
}
