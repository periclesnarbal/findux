//
//  SimulatorView.swift
//  findux
//
//  Created by Péricles Narbal on 30/10/23.
//

import UIKit
import SwiftUI

class SimulatorView: BaseView<SimulatorCoordinator> {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        backgroundColor = .white
        
        if let view: UIView = loadViewFromNib() {
            addViewToBounds(view)
        }
    }
}

struct SimulatorViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SimulatorView()
        }.edgesIgnoringSafeArea(.all)
    }
}
