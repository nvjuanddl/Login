//
//  LoginWelcomeInterfaces.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import Foundation

enum LoginWelcomeNavigationOption { }

protocol LoginWelcomeWireframeInterface: WireframeInterface {
    func navigate(to option: LoginWelcomeNavigationOption)
}

protocol LoginWelcomeViewInterface: ViewInterface { 
    func reloadView()
}

protocol LoginWelcomePresenterInterface: PresenterInterface { 
    var items: [String] { get }
}

protocol LoginWelcomeInteractorInterface: InteractorInterface {
    func getUser(email: String, completion: @escaping (User) -> Void)
}
