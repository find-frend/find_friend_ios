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
        case .name:
            validateName(text)
        case .lastName:
            validateLastName(text)
        case .email:
            validateEmail(text)
        case .password:
            validatePassword(text)
        case .confirmPassword:
            validateConfirmPassword(text)
        }
    }
    private init() {}
    
    private static func validateName(_ name: String) -> String? {
        if name.isEmpty {
            return "Поле не может быть пустым"
        }
        
        let letters = CharacterSet.letters
        if !CharacterSet(charactersIn: name).isSubset(of: letters) {
            return "Введены недопустимые символы"
        }
        
        if name.count < 2 || name.count > 150 {
            return "Имя должно содержать от 2 до 150 символов"
        }
        return nil
    }
    
    private static func validateLastName(_ lastName: String) -> String? {
        if lastName.isEmpty {
            return "Поле не может быть пустым"
        }
        
        let letters = CharacterSet.letters
        if !CharacterSet(charactersIn: lastName).isSubset(of: letters) {
            return "Введены недопустимые символы"
        }
        
        if lastName.count < 2 || lastName.count > 150 {
            return "Фамилия должна содержать от 2 до 150 символов"
        }
        return nil
    }
    
    private static func validateEmail(_ email: String) -> String? {
        if email.isEmpty {
            return "Поле не может быть пустым"
        }
        
        let emailSet = CharacterSet(charactersIn: email)
        let letters = CharacterSet(
            charactersIn: """
                          ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
                          1234567890@.
                          """
        )
            
        if !emailSet.isSubset(of: letters) {
            return "Введены недопустимые символы"
        }
        
        if email.count < 5 || email.count > 254 {
            return "Почта должна содержать от 5 до 254 символов"
        }
        return nil
    }
    
    private static func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Поле не может быть пустым"
        }
        if password.count < 5 || password.count > 254 {
            return "Пароль должен содержать от 8 до 50 символов"
        }
        return nil
    }
    
    private static func validateConfirmPassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Поле не может быть пустым"
        }
        return nil
    }
}
