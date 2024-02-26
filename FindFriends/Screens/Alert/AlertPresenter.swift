//
//  AlertPresenter.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//


import UIKit

// MARK: - AlertPresenter
final class AlertPresenter {
    
    static func show(in controller: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: model.preferredStyle
        )
        for button in model.buttons {
            let action = UIAlertAction(title: button.text, style: button.style) { _ in
                button.completion(())
            }
            alert.addAction(action)
            if button.isPreferredAction {
                alert.preferredAction = action
            }
        }
        if controller.presentedViewController == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }

}
