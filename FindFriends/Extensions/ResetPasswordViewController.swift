//
//  ResetPasswordViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit


// MARK: - ResetPasswordViewController
final class ResetPasswordViewController: UIViewController {

    // MARK: - Private properties
    private let resetPasswordView = ResetPasswordView()

    // MARK: - Overridden methods
    override func loadView() {
        view = resetPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        hideKeyboardWhenTappedAround()
        resetPasswordView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Сброс пароля"
    }

}


// MARK: - ResetPasswordViewController
extension ResetPasswordViewController: ResetPasswordViewDelegate {

    func didTapSendInstructionButton() {
        // TODO: handle action
        print("didTapSendInstructionButton")
    }

}
