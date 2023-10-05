//
//  PresentationView.swift
//  findux
//
//  Created by Péricles Narbal on 02/10/23.
//

import UIKit
import SwiftUI

class PresentationView: BaseView<PresentationCoordinator> {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        if let view: UIView = loadViewFromNib() {
            addViewToBounds(view)
        }
    }
}

struct PresentationViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PresentationView()
        }.edgesIgnoringSafeArea(.all)
    }
}
