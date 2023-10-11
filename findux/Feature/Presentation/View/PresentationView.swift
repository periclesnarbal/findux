//
//  PresentationView.swift
//  findux
//
//  Created by Péricles Narbal on 02/10/23.
//

import UIKit
import SwiftUI

class PresentationView: BaseView<PresentationCoordinator> {
    
    var viewModelDelegate: PresentationViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var dontShowAgainSwitch: UISwitch!
    
    @IBAction func continueButtonAction(_ sender: UIButton) { // TODO: VAI PRA PROXIMA VIEW
        coordinatorDelegate?.goToCourses()
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
    
    func setupView(dataModel: PresentationViewData) {
        titleLabel.text = dataModel.title
        descriptionLabel.text = dataModel.description
        continueButton.setTitle(dataModel.buttonTitle, for: .normal)
    }
}

struct PresentationViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            PresentationView()
        }.edgesIgnoringSafeArea(.all)
    }
}
