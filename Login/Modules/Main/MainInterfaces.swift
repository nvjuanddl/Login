//
//  MainInterfaces.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import Foundation


enum MainFlow {
    case signIn
    case signUp
}

enum MainNavigationOption {
    case loginWelcome(email: String)
}

protocol MainWireframeInterface: WireframeInterface {
    func navigate(to option: MainNavigationOption)
}

protocol MainViewInterface: ViewInterface { }

protocol MainPresenterInterface: PresenterInterface {
    func getNumberOfItem(at flow: MainFlow) -> Int
    func getItems(at flow: MainFlow) -> [TextFieldType]
    func getItem(with indexPath: IndexPath, at flow: MainFlow) -> (tag: Int, placeholder: String)
    func shouldAcceptInput(tag: Int, fieldValue: String?, input: String) -> Bool
    func checkTextField(tag: Int, fieldValue: String?)
    func goToLoginWelcomeIfPossible(at flow: MainFlow)
    func cleanData()
}

protocol MainInteractorInterface: InteractorInterface {
    func signInIfPossible(email: String, password: String, completion: @escaping (String?) -> Void)
    func signUpIfPossible(data: [String: String], completion: @escaping (String?) -> Void)
}
