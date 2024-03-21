//
//  AlertModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import UIKit

struct AlertModel {
    let title = "Внимание"
    let message: String
    let buttons: [AlertButton<Void>] = [
        AlertButton(
            text: "Понятно",
            style: .cancel,
            completion: { _ in })
    ]
    let preferredStyle: UIAlertController.Style = .alert
}
