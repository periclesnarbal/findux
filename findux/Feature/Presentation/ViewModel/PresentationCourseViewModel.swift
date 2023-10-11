//
//  PresentationCourseViewModel.swift
//  findux
//
//  Created by Péricles Narbal on 11/10/23.
//

import Foundation

class PresentationCourseViewModel: PresentationViewModelProtocol {
    
    unowned var viewDelegate: PresentationViewProtocol
    let userDefaults: UserDefaultsManager
    let dataModel = PresentationViewData(
        title: "Cursos",
        description: "Aqui você pode encontrar um compilado de cursos escolhidos criteriosamente pela equipe do findux",
        buttonTitle: "Continuar")
    
    required init(viewDelegate: PresentationViewProtocol, userDefaults: UserDefaultsManager) {
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
