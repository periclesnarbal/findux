//
//  LifeCycleViewControllerDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit

protocol LifeCycleViewControllerDelegate: NSObject {
    func loadView()
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillLayoutSubviews()
    func viewDidLayoutSubviews()
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

extension LifeCycleViewControllerDelegate {
    ///This method use when view Controller creates from code . Its good not to do anything on this method.If view Controller made from .xib or storyboard.
    func loadView() {
        // Optional implementation
    }

    ///This Method is loaded once in view controller life cycle .Its Called When all the view are loaded.
    ///Ex: Network call which need Once, User Interface, Others Task Those are Need to do Once.
    ///Note: This Method Call before the bound are defined and rotation happen.So its Risky to work view size in this method.
    func viewDidLoad() {
        // Optional implementation
    }
    
    ///This method is called every time before the view is visible to and before any animation is configured. In this method view has bound but orientation is not set yet.
    func viewWillAppear(_ animated: Bool) {
        // Optional implementation
    }

    ///It doesn’t do Anything by default. When a view’s bounds change, the view adjusts the position of its subviews.
    func viewWillLayoutSubviews() {
        // Optional implementation
    }

    ///This method is called after the viewController has been adjusting to its subview following a change on its bound.
    func viewDidLayoutSubviews() {
        // Optional implementation
    }

    ///This method is called after the view present on the screen. Usually, save data to core data or start animation or start playing a video or a sound, or to start collecting data from the network
    func viewDidAppear(_ animated: Bool) {
        // Optional implementation
    }

    ///This method is called before the view is removed from the view hierarchy. The View is Still on the view hierarchy but not removed yet. any unload animations haven’t been configured yet.
    /// Add code here to handle timers, hide the keyboard, canceling network requests, revert any changes to the parent UI. Also, this is an ideal place to save the state.
    func viewWillDisappear(_ animated: Bool) {
        // Optional implementation
    }

    ///This method is called after the VC’s view has been removed from the view hierarchy. Use this method to stop listening for notifications or device sensors.
    func viewDidDisappear(_ animated: Bool) {
        // Optional implementation
    }
}

