//
//  PresentationViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 10/10/23.
//

import Foundation

class PresentationViewModel {
    
    unowned var viewDelegate: PresentationView
    let userDefaults: UserDefaultsManager
    let dataModel = PresentationViewData(
        title: "Cursos",
        description: "Aqui você pode encontrar um compilado de cursos escolhidos criteriosamente pela equipe do findux",
        buttonTitle: "Continuar")
    
    init(viewDelegate: PresentationView, userDefaults: UserDefaultsManager) {
        self.viewDelegate = viewDelegate
        self.userDefaults = userDefaults
        
        self.viewDelegate.viewModelDelegate = self
        self.viewDelegate.setupView(dataModel: dataModel)
    }
    
    func dontShowAgainSwitchAction(_ isOn: Bool) {
        if let title = dataModel.title {
            userDefaults.createItem(title, value: isOn)
        }
    }
}
