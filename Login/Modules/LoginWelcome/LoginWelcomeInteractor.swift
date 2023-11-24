//
//  LoginWelcomeInteractor.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import Foundation

final class LoginWelcomeInteractor: LoginWelcomeInteractorInterface {
    
    func getUser(email: String, completion: @escaping (User) -> Void) {
        guard let user: User = LocalDataManager().getObject(key: TextFieldType.email.key, value: email) else { return }
        completion(user)
    }
}
