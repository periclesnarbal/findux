//
//  CoursesView.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import UIKit

class CoursesView: BaseView<CoursesCoordinator> {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        
    }
}
