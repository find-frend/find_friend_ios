//
//  AlertModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import UIKit

struct AlertModel {

    let title: String
    let message: String?
    let buttons: [AlertButton<Void>]
    let preferredStyle: UIAlertController.Style

    static func loginError(message: String = "") -> AlertModel {
        baseError(title: "Не удалось авторизоваться", message: message)
    }

    static func resetPasswordError(message: String = "") -> AlertModel {
        baseError(title: "Проверьте введенный e-mail", message: message)
    }

    static func newPasswordError(message: String = "") -> AlertModel {
        baseError(title: "При изменении пароля произошла ошибка", message: message)
    }

    private static func baseError(title: String, message: String = "") -> AlertModel {
        AlertModel(
            title: title,
            message: message,
            buttons: [
                AlertButton(
                    text: "Ок",
                    style: .default,
                    completion: {}
                )
            ],
            preferredStyle: .alert
        )
    }
}
