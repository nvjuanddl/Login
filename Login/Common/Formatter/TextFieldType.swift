//
//  TextFieldType.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import Foundation

enum TextFieldType: Int, CaseIterable {
    case name = 231120231
    case email = 231120232
    case password = 231120233
    case phoneNumber = 231120234
    
    var key: String {
        switch self {
        case .email: return "email"
        case .name: return "name"
        case .password: return "password"
        case .phoneNumber: return "phoneNumber"
        }
    }
    
    var placeholder: String {
        switch self {
        case .name: return "Name"
        case .email: return "Email"
        case .password: return "Password"
        case .phoneNumber: return "Contact Number"
        }
    }
    
    var error: String {
        switch self {
        case .name: 
            return "Name field must accept alphanumeric values."
        case .email:
            return "Email field must accept a valid email address."
        case .password:
            return """
                   Password field must accept a password if and only if it is at least 6 characters long and meets the following criteria:
                   • One or more uppercase characters.
                   • One or more lowercase characters.
                   • One or more digits.
                   • One or more special characters.
                   """
        case .phoneNumber:
            return "Phone Number field must accept only 10-digit phone numbers."
        }
    }
}
