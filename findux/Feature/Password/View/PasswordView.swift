//
//  PasswordView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit
import GoogleSignIn
import SwiftUI

class PasswordView: BaseView<PasswordCoordinator> {
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var separatorView: SeparatorView!
    
    @IBAction func googleSignInButtonAction(_ sender: Any) {
        coordinatorDelegate?.handleGoogleSignIn()
    }
    
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
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true
            addSubview(view)
        }
        
        separatorView.label.text = "Or"
    }
}

//extension PasswordView: LifeCycleViewControllerDelegate {
//    func loadView() {
//        if let view: UIView = loadViewFromNib() {
//            view.frame = bounds
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.translatesAutoresizingMaskIntoConstraints = true
//            addSubview(view)
//        }
//    }
//}

struct PasswordViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PasswordView()
        }.edgesIgnoringSafeArea(.all)
    }
}
