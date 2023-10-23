//
//  PresentationView.swift
//  findux
//
//  Created by Péricles Narbal on 02/10/23.
//

import UIKit
import SwiftUI

protocol PresentationViewProtocol: AnyObject {
    var viewModelDelegate: PresentationViewModelProtocol? { get set }
    
    func setupView(presentationModel: PresentationModel)
}

class PresentationView: BaseView<PresentationCoordinator> {
    
    var viewModelDelegate: PresentationViewModelProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var dontShowAgainSwitch: UISwitch!
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        coordinatorDelegate?.dismiss()
    }
    
    @IBAction func dontShowAgainSwitchAction(_ sender: UISwitch) {
        viewModelDelegate?.dontShowAgainSwitchAction(sender.isOn)
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
            addViewToBounds(view)
        }
    }
}

extension PresentationView: PresentationViewProtocol {
    func setupView(presentationModel: PresentationModel) {
        titleLabel.text = presentationModel.title
        descriptionLabel.text = presentationModel.description
        continueButton.setTitle(presentationModel.buttonTitle, for: .normal)
    }
}

struct PresentationViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PresentationView()
        }.edgesIgnoringSafeArea(.all)
    }
}
