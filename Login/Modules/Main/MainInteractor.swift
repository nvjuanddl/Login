//
//  MainInteractor.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import Foundation


final class MainInteractor: MainInteractorInterface {
    
    func signInIfPossible(email: String, password: String, completion: @escaping (String?) -> Void) {
        let user: User? = LocalDataManager().getObject(key: TextFieldType.email.key, value: email)
        return password == user?.password ? completion(user?.email) : completion(nil)
    }
    
    func signUpIfPossible(data: [String: String], completion: @escaping (String?) -> Void) {
        let user: User? = LocalDataManager().getObject(key: TextFieldType.email.key, value: data[TextFieldType.email.key] ?? kEmptyString)
        if user == nil {
            self.save(data: data, completion: completion)
        } else {
            completion(nil)
        }
    }
    
    private func save(data: [String: String], completion: @escaping (String?) -> Void) {
        do {
            let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            LocalDataManager().save(data: json, type: User.self)
            completion(data[TextFieldType.email.key])
        } catch {
            completion(nil)
        }
    }
}
