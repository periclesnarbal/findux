//
//  HomeViewController.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit
import GoogleSignIn

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
        let coursesCoordinator = buildChildCoordinator(childType: CoursesCoordinator.self, parentCoordinator: self)
        coursesCoordinator.start { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.goToPresentation(presentationModel: weakSelf.cursesModel)
        }
    }
    
    func goToSimulator() {
        let simulatorCoordinator = buildChildCoordinator(childType: SimulatorCoordinator.self, parentCoordinator: self)
        simulatorCoordinator.start()
    }
    
    func goToPresentation(presentationModel: PresentationModel) {
        let hidePresentation = userDefaults.readItem(presentationModel.title ?? "") ?? false
        if !hidePresentation {
            parentCoordinator.goToPresentationCoordinator(presentationModel: presentationModel)
        }
    }
    
    func openProfileModal() {
        let user = UserGIDProfile.shared
        
        let alertController = UIAlertController(title: user.givenName, message: user.email, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Logoff", style: .default) { (_) in
            self.backToViewController(PasswordViewController.self)
            GIDSignIn.sharedInstance.signOut()
            UserGIDProfile.shared.clearValues()
        }
        
        let action2 = UIAlertAction(title: "Limpar preferências", style: .default) { (_) in
            let presentationList = ["Cursos"]
            presentationList.forEach({ self.userDefaults.deleteItem($0) })
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(cancelAction)
        
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
