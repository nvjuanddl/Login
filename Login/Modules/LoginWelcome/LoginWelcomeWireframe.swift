//
//  LoginWelcomeWireframe.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import UIKit

final class LoginWelcomeWireframe: BaseWireframe {
    
    // MARK: - Lifecycle -
    
    init(email: String) {
        let moduleViewController = LoginWelcomeViewController()
        super.init(viewController: moduleViewController)
        let interactor = LoginWelcomeInteractor()
        let presenter = LoginWelcomePresenter(wireframe: self, view: moduleViewController, interactor: interactor, email: email)
        moduleViewController.presenter = presenter
    }
}

// MARK: - LoginWelcomeWireframeInterface -

extension LoginWelcomeWireframe: LoginWelcomeWireframeInterface {
    func navigate(to option: LoginWelcomeNavigationOption) {
    }
}
