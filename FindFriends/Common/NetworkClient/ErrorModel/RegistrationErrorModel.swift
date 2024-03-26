//
//  ErrorModel.swift
//  FindFriends
//
//  Created by Вадим Шишков on 13.03.2024.
//

import Foundation

struct RegistrationErrorModel: Decodable {
    let password: [String]?
    let email: [String]?
    let nonFieldErrors: [String]?
    
    var currentError: String {
        if let email {
            return email.joined(separator: " ")
        } else if let password {
            return password.joined(separator: " ")
        } else if let nonFieldErrors {
            return nonFieldErrors.joined(separator: " ")
        } else {
            return "Неизвестная ошибка"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case password, email
        case nonFieldErrors = "non_field_errors"
    }
}
