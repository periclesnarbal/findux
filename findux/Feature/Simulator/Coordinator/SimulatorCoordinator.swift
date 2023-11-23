//
//  SimulatorCoordinator.swift
//  findux
//
//  Created by Péricles Narbal on 30/10/23.
//

import UIKit

final class SimulatorCoordinator: BaseChildCoordinator<HomeCoordinator> {
    
    let investmentModel = PresentationModel(
        title: "Simulador de Investimento",
        description: """
                Uma ferramenta para te ajudar a alcançar seus sonhos.
                
                Calcule aqui o que quiser, deixe em branco apenas o campo que você quer calcular e o Investimento Inicial, caso não haja.

                Transforme o resultado em uma meta e adicione seus investimentos mensais no seu planejamento financeiro como um gasto com você mesmo.
                """,
        buttonTitle: "Continuar")
    
    let financingModel = PresentationModel(
        title: "Simulador de Financiamento",
        description: """
                Calcule aqui o o quanto você vai pagar ao todo por uma troca intertemporal, para ter agora o que você não tem o dinheiro para comprar.

                *Caso não sejam eles que você esteja calculando, Lembre-se de usar o Custo Efetivo Total como Juros.
                """,
        buttonTitle: "Continuar")
    
    let userDefaults = UserDefaultsManager.shared
    
    override func start() {
        goToSimulatorViewController()
    }
    
    func goToSimulatorViewController() {
        let vc = SimulatorViewController()
        let view = SimulatorView()
        vc.loadContentView(view)
        //        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToFinancing() {
        let vc = FinancingViewController()
        let view = FinancingView()
        vc.loadContentView(view)
        //        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
        
        goToPresentation(presentationModel: financingModel)
    }
    
    func goToInvestiment() {
        let vc = InvestmentViewController()
        let view = InvestmentView()
        vc.loadContentView(view)
        //        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
        
        goToPresentation(presentationModel: investmentModel)
    }
    
    func goToInvestimentDetail(investmentSimulatorModel: InvestmentSimulatorModel) {
        let vc = InvestmentDetailViewController()
        let view = InvestmentDetailView()
        _ = InvestmentDetailViewModel(viewDelegate: view, investmentSimulatorModel: investmentSimulatorModel)
        vc.loadContentView(view)
        //        vc.lifeCycleDelegate = view
        vc.fullAccessDelegate = view
        view.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPresentation(presentationModel: PresentationModel) {
        parentCoordinator.goToPresentation(presentationModel: presentationModel)
    }
}
