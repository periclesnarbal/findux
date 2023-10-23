//
//  HomeViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit

final class HomeCoordinator: BaseChildCoordinator<MainCoordinator> {
    typealias Closure = () -> Void
    
    let userDefaults = UserDefaultsManager.shared
    
    let cursesModel = PresentationModel(
        title: "Cursos",
        description: "Aqui você pode encontrar um compilado de cursos escolhidos criteriosamente pela equipe do findux",
        buttonTitle: "Continuar")
    
    override func start() {
        goToHomeViewController()
    }
    
    func goToHomeViewController() {
        let vc = HomeViewController()
        let view = HomeView()
        vc.loadContentView(view)
//        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCourses() {
        goToPageWithPresentation(presentationModel: cursesModel, completion: parentCoordinator.goToCoursesCoordinator)
    }
    
    func goToPageWithPresentation(presentationModel: PresentationModel, completion: (Closure?) -> Void) {
        completion { [weak self] in
            guard let weakSelf = self else { return }
            let hidePresentation = weakSelf.userDefaults.readItem(presentationModel.title ?? "") ?? false
            if !hidePresentation {
                weakSelf.parentCoordinator.goToPresentationCoordinator(presentationModel: presentationModel)
            }
        }
    }
}
