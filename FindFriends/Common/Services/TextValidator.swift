//
//  TextValidator.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import Foundation

struct TextValidator {
    
    static func validate(_ text: String, with type: TextFieldType) -> Result<Void, ValidateMessages> {
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
    
    private static func validateName(_ name: String) -> Result<Void, ValidateMessages> {
        if name.isEmpty {
            return .failure(.emptyField)
        }
        if name.count < 2 || name.count > 150 {
            return .failure(.nameLength)
        }
        let letters = CharacterSet.letters
        if !CharacterSet(charactersIn: name).isSubset(of: letters) {
            return .failure(.incorrectSymbols)
        }
        return .success(Void())
    }
    
    private static func validateLastName(_ lastName: String) -> Result<Void, ValidateMessages> {
        if lastName.isEmpty {
            return .failure(.emptyField)
        }
        if lastName.count < 2 || lastName.count > 150 {
            return .failure(.lastNameLength)
        }
        let letters = CharacterSet.letters
        if !CharacterSet(charactersIn: lastName).isSubset(of: letters) {
            return .failure(.incorrectSymbols)
        }
        return .success(Void())
    }
    
    private static func validateEmail(_ email: String) -> Result<Void, ValidateMessages> {
        if email.isEmpty {
            return .failure(.emptyField)
        }
        if email.count < 5 || email.count > 254 {
            return .failure(.emailLength)
        }
        
        let emailSet = CharacterSet(charactersIn: email)
        let letters = CharacterSet(
            charactersIn: """
                          ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
                          1234567890-_@.
                          """
        )
        if !emailSet.isSubset(of: letters) {
            return .failure(.incorrectSymbolsInEmail)
        }
        if !emailSet.isSuperset(of: CharacterSet(charactersIn: "@.")) {
            return .failure(.incorrectSymbols)
        }
        return .success(Void())
    }
    
    private static func validatePassword(_ password: String) -> Result<Void, ValidateMessages> {
        if password.isEmpty {
            return .failure(.emptyField)
        }
        if password.count < 8 || password.count > 50 {
            return .failure(.passwordLength)
        }
        return .success(Void())
    }
    
    private static func validateConfirmPassword(_ password: String) -> Result<Void, ValidateMessages> {
        if password.isEmpty {
            return .failure(.emptyField)
        }
        return .success(Void())
    }
}

enum ValidateMessages: String, Error {
    case emptyMessage = ""
    case emptyField = "Поле не может быть пустым"
    case incorrectSymbols = "Введены недопустимые символы"
    case nameLength = "Имя должно содержать от 2 до 150 символов"
    case lastNameLength = "Фамилия должна содержать от 2 до 150 символов"
    case emailLength = "Почта должна содержать от 5 до 254 символов"
    case passwordLength = "Пароль должен содержать от 8 до 50 символов"
    case incorrectSymbolsInEmail = "Почта должна содержать буквы только английского алфавита"
    case passwordsNotEqual = "Пароли не совпадают"
}
