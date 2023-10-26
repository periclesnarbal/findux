//
//  CoursesCellModel.swift
//  findux
//
//  Created by Péricles Narbal on 17/10/23.
//

import Foundation

struct CoursesModel: Decodable {
    let title: String?
    let author: String?
    let description: String?
    let link: String?
}

struct CoursesCellModel {
    typealias Closure = () -> Void
    
    let title: String?
    let author: String?
    let description: String?
    let link: String?
    let action: Closure?
    
    init(courses: CoursesModel, action: Closure?) {
        title = courses.title
        author = courses.author
        description = courses.description
        link = courses.link
        self.action = action
    }
}
