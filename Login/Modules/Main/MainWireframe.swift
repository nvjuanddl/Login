//
//  MainWireframe.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import UIKit

final class MainWireframe: BaseWireframe {
    
    // MARK: - Lifecycle -
    
    init() {
        let moduleViewController = MainViewController()
        super.init(viewController: moduleViewController)
        let interactor = MainInteractor()
        let presenter = MainPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }
}

// MARK: - MainWireframeInterface -

extension MainWireframe: MainWireframeInterface {
    func navigate(to option: MainNavigationOption) {
        switch option {
        case .loginWelcome(let email):
            let viewController = LoginWelcomeWireframe(email: email).viewController
            self.viewController.view.window?.rootViewController = viewController
        }
    }
}
