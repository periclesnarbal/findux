//
//  PresentationViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import Foundation

protocol PresentationViewModelProtocol {
    var viewDelegate: PresentationViewProtocol { get }
    var userDefaults: UserDefaultsManager { get }
    var presentationModel: PresentationModel { get }
    
    init(viewDelegate: PresentationViewProtocol, userDefaults: UserDefaultsManager, presentationModel: PresentationModel)
    func dontShowAgainSwitchAction(_ isOn: Bool)
}

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
