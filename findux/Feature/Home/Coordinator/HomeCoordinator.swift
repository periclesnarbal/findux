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
    
    let simulatorModel = PresentationModel(
        title: "Simulador",
        description: """
                Calcule aqui o o quanto você vai pagar ao todo por uma troca intertemporal, para ter agora o que você não tem o dinheiro para comprar.
                
                *Caso não sejam eles que você esteja calculando, Lembre-se de usar o Custo Efetivo Total como Juros.
                """,
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
    
    func goToSimulator() {
        goToPageWithPresentation(presentationModel: simulatorModel, completion: parentCoordinator.goToSimulatorCoordinator)
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
