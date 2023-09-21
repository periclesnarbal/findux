//
//  EyeButton.swift
//  findux
//
//  Created by Péricles Narbal on 13/09/23.
//

import UIKit
import SwiftUI

class EyeButton: UIButton {
    enum Status {
        case opened
        case closed
        
        mutating func toggle() {
            switch self {
            case .opened: self = .closed
            case .closed: self = .opened
            }
        }
    }
    
    var openedEyeImage = UIImage(systemName: "eye")
    var closedEyeImage = UIImage(systemName: "eye.slash")
    
    private var defaultImage: UIImage? {
        switch status {
        case .closed: return closedEyeImage
        case .opened: return openedEyeImage
        }
    }
    
    var status: Status = .closed {
        didSet {
           action?(status)
        }
    }
    
    var action: ((Status) -> Void)?

    init(frame: CGRect = .zero, action: ((Status) -> Void)?) {
        super.init(frame: frame)
        
        self.action = { [weak self] (status: Status) in
            if let weakSelf = self {
                action?(weakSelf.status)
            }
        }
        
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    private func commomInit() {
        setImage(defaultImage, for: .normal)
        tintColor = .gray
        imageView?.contentMode = .scaleAspectFit
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
    }
    
    @objc func eyeButtonAction() {
        status.toggle()
        setImage(defaultImage, for: .normal)
    }
}

struct EyeButtonPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            EyeButton { status in
                print(status)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
