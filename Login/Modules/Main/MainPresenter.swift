//
//  MainPresenter.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import Foundation

final class MainPresenter {
    
    // MARK: - Private properties -
    
    private unowned var view: MainViewInterface
    private var interactor: MainInteractorInterface
    private var wireframe: MainWireframeInterface
    private var user: User?
    
    var fieldErrors: Set<TextFieldType> = Set()
    var fieldValues: [String: String] = [:]
    var signUpData: [TextFieldType] = [.name, .password, .email, .phoneNumber]
    var logInData: [TextFieldType] = [.email, .password]
    
    // MARK: - Lifecycle -
    
    init(
        wireframe: MainWireframeInterface,
        view: MainViewInterface,
        interactor: MainInteractorInterface
    ) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
    }
    
    private func showErrorAlert(with message: String) {
        wireframe.showAlert(
            alertViewModel: AlertViewModel(
                title: "Error",
                message: message,
                dismissActionTitle: "Ok"
            )
        )
    }
}

// MARK: - MainPresenterInterface -

extension MainPresenter: MainPresenterInterface {
    
    func getNumberOfItem(at flow: MainFlow) -> Int {
        switch flow {
        case .signIn: return logInData.count
        case .signUp: return signUpData.count
        }
    }
    
    func showFieldError() {
        for error in fieldErrors {
            showErrorAlert(with: error.error)
            break
        }
    }
    
    func goToLoginWelcomeIfPossible(at flow: MainFlow) {
        guard fieldErrors.isEmpty else {
            showFieldError()
            return
        }
        
        switch flow {
        case .signIn where fieldValues.count == logInData.count:
            let email = fieldValues[TextFieldType.email.key] ?? kEmptyString
            let password = fieldValues[TextFieldType.password.key] ?? kEmptyString
            interactor.signInIfPossible(email: email, password: password) { [weak self] email in
                guard let self else { return }
                guard let email else {
                    self.showErrorAlert(with: "Error")
                    return
                }
                self.wireframe.navigate(to: .loginWelcome(email: email))
            }
        case .signUp where fieldValues.count == signUpData.count:
            interactor.signUpIfPossible(data: fieldValues) { [weak self] email in
                guard let self else { return }
                guard let email else {
                    self.showErrorAlert(with: "Error")
                    return
                }
                self.wireframe.navigate(to: .loginWelcome(email: email))
            }
        default:
            showErrorAlert(with: "Error")
        }
    }
    
    func cleanData() {
        fieldErrors = []
        fieldValues = [:]
    }
    
    func getItems(at flow: MainFlow) -> [TextFieldType] {
        switch flow {
        case .signIn: return logInData
        case .signUp: return signUpData
        }
    }
    
    func getItem(with indexPath: IndexPath, at flow: MainFlow) -> (tag: Int, placeholder: String) {
        switch flow {
        case .signIn:
            let item = logInData[indexPath.row]
            return (item.rawValue, item.placeholder)
        case .signUp:
            let item = signUpData[indexPath.row]
            return (item.rawValue, item.placeholder)
        }
    }
    
    func shouldAcceptInput(tag: Int, fieldValue: String?, input: String) -> Bool {
        guard !input.haveEmojis, let field = TextFieldType(rawValue: tag) else { return false }
        switch field {
        case .name:
            guard input.isValidAlphanumeric else { return false }
        case .phoneNumber:
            guard input.isValidNumber, ((fieldValue?.count ?? .zero) + input.count) <= 10 else { return false }
        default:
            break
        }
        
        return true
    }
    
    func addError(field: TextFieldType) {
        fieldErrors.insert(field)
        fieldValues.removeValue(forKey: field.key)
    }
    
    func checkTextField(tag: Int, fieldValue: String?) {
        guard let field = TextFieldType(rawValue: tag) else { return }
        guard let fieldValue, !fieldValue.isEmpty else {
            fieldErrors.insert(field)
            return
        }
                
        switch field {
        case .name:
            guard fieldValue.isValidAlphanumeric else {
                addError(field: field)
                return
            }
        case .phoneNumber:
            guard fieldValue.isValidNumber, fieldValue.count == 10 else {
                addError(field: field)
                return
            }
        case .email:
            guard fieldValue.isEmail else {
                addError(field: field)
                return
            }
        case .password:
            guard fieldValue.isValidPassword else {
                addError(field: field)
                return
            }
        }
        
        fieldErrors.remove(field)
        fieldValues[field.key] = fieldValue
    }
}

