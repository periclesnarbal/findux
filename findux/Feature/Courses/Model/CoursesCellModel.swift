//
//  CoursesCellModel.swift
//  findux
//
//  Created by Péricles Narbal on 17/10/23.
//

import Foundation

struct CoursesCellModel {
    typealias Closure = () -> Void
    
    let title: String?
    let author: String?
    let description: String?
    let action: Closure?
}
