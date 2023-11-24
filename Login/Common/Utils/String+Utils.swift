//
//  String+Utils.swift
//  Login
//
//  Created by Juan Delgado Lasso on 24/11/23.
//

import Foundation

extension String {
        
    var haveEmojis: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF,  // Misc Symbols and Pictographs
                0x1F680...0x1F6FF,  // Transport and Map
                0x1F1E6...0x1F1FF,  // Regional country flags
                0x2600...0x26FF,    // Misc symbols
                0x2700...0x27BF,    // Dingbats
                0xFE00...0xFE0F,    // Variation Selectors
                0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
                127000...127600,    // Various asian characters
                65024...65039,      // Variation selector
                9100...9300,        // Misc items
                8400...8447:        // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    var isEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isValidAlphanumeric: Bool {
        let regex = "[a-zA-Z0-9 ]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
        
    var isValidPassword: Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isValidNumber: Bool {
        let regex = "[0-9]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
