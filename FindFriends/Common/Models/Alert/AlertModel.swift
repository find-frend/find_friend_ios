//
//  AlertModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import UIKit

// MARK: - AlertModel
struct AlertModel {

    let title: String
    let message: String?
    let buttons: [AlertButton<Void>]
    let preferredStyle: UIAlertController.Style

    static func loginError(message: String = "") -> AlertModel {
        AlertModel(
            title: "Не удалось авторизоваться",
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
