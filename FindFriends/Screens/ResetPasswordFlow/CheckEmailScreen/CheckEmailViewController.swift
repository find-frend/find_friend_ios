//
//  CheckEmailViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit

final class CheckEmailViewController: UIViewController {
    private let checkEmailView = CheckEmailView()

    override func loadView() {
        self.view = checkEmailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        checkEmailView.delegate = self
    }

    private func configureNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: false)
    }
}

// MARK: - CheckEmailViewDelegate

extension CheckEmailViewController: CheckEmailViewDelegate {
    func didTapBackToResetPasswordButton() {
        navigationController?.popViewController(animated: true)
    }

    func didTapBackToLogInButton() {
        navigationController?.popToRootViewController(animated: true)
    }
}

