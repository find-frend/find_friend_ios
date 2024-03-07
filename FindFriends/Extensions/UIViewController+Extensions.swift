//
//  UIViewController+Extensions.swift
//  FindFriends
//
//  Created by Artem Novikov on 20.02.2024.
//

import UIKit


// MARK: - UIViewController
extension UIViewController {

    func hideKeyboardWhenTappedAround(cancelsTouchesInView: Bool = false) {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard)
        )
        tap.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

