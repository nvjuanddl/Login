//
//  LoginWelcomePresenter.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import Foundation

final class LoginWelcomePresenter {
    
    // MARK: - Private properties -
    
    private unowned var view: LoginWelcomeViewInterface
    private var wireframe: LoginWelcomeWireframeInterface
    private var interactor: LoginWelcomeInteractorInterface
    private var email: String
    
    // MARK: - Public properties -
    
    var items: [String] = []
    
    // MARK: - Lifecycle -
    
    init(
        wireframe: LoginWelcomeWireframeInterface,
        view: LoginWelcomeViewInterface,
        interactor: LoginWelcomeInteractorInterface,
        email: String
    ) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.email = email
    }
}

// MARK: - LoginWelcomePresenterInterface -

extension LoginWelcomePresenter: LoginWelcomePresenterInterface {
    
    func viewDidLoad() {
        interactor.getUser(email: email) { [weak self] user in
            guard let self else { return }
            self.items = [user.email, user.name, user.phoneNumber]
            view.reloadView()
        }
    }
}
