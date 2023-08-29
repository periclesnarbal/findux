//
//  BaseViewController.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    weak var lifeCycleDelegate: LifeCycleViewControllerDelegate?
    weak var fullAccessDelegate: FullAccessViewControllerDelegate?
    
    var contentView: any ViewCoordinatorDelegate = {
        let view = BaseView<BaseChildCoordinator<BaseCoordinator>>()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews() {
        view.addSubview(contentView)
    }
    
    func setupConstraints() {
        view.embedConstraints(contentView)
    }
    
    func loadContentView(_ anyView: any ViewCoordinatorDelegate) {
        anyView.translatesAutoresizingMaskIntoConstraints = false
        contentView = anyView
    }
    
    override func loadView() {
        super.loadView()
        lifeCycleDelegate?.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        lifeCycleDelegate?.viewDidLoad()
        fullAccessDelegate?.getNavigationController(navigationController)
        fullAccessDelegate?.getNavigationItem(navigationItem)
        fullAccessDelegate?.getViewController(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifeCycleDelegate?.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        lifeCycleDelegate?.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lifeCycleDelegate?.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifeCycleDelegate?.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifeCycleDelegate?.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifeCycleDelegate?.viewDidDisappear(animated)
    }
    
    deinit {
        print("\(self) DEINIT")
    }
}
