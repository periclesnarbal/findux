//
//  PresentationViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 10/10/23.
//

import Foundation

protocol PresentationViewModelProtocol {
    var viewDelegate: PresentationViewProtocol { get }
    var userDefaults: UserDefaultsManager { get }
    var dataModel: PresentationViewData { get }
    
    init(viewDelegate: PresentationViewProtocol, userDefaults: UserDefaultsManager)
    func dontShowAgainSwitchAction(_ isOn: Bool)
}
