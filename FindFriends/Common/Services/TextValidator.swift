//
//  TextValidator.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import Foundation

struct TextValidator {
    
    static func validate(_ text: String, with type: TextFieldType) -> String? {
        switch type {
        case .personal:
            validatePersonal(text)
        case .email:
            validateEmail(text)
        case .password:
            validatePassword(text)
        case .confirmPassword:
            validateConfirmPassword(text)
        }
    }
    
    private static func validatePersonal(_ text: String) -> String? {
        return nil
    }
    
    private static func validateEmail(_ email: String) -> String? {
        return nil
    }
    
    private static func validatePassword(_ password: String) -> String? {
        return nil
    }
    
    private static func validateConfirmPassword(_ password: String) -> String? {
        return nil
    }
}
