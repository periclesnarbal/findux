//
//  PresentationViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import Foundation

class PresentationViewModel: PresentationViewModelProtocol {
    
    unowned var viewDelegate: PresentationViewProtocol
    let userDefaults: UserDefaultsManager
    let presentationModel: PresentationModel
    
    required init(viewDelegate: PresentationViewProtocol, userDefaults: UserDefaultsManager, presentationModel: PresentationModel) {
        self.viewDelegate = viewDelegate
        self.userDefaults = userDefaults
        self.presentationModel = presentationModel
        
        self.viewDelegate.viewModelDelegate = self
        self.viewDelegate.setupView(presentationModel: presentationModel)
    }
    
    func dontShowAgainSwitchAction(_ isOn: Bool) {
        if let title = presentationModel.title {
            userDefaults.createItem(title, value: isOn)
        }
    }
}
