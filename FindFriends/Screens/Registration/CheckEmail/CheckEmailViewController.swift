//
//  CheckEmailViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit


// MARK: - CheckEmailViewController
final class CheckEmailViewController: UIViewController {

    // MARK: - Private properties
    private let checkEmailView = CheckEmailView()

    // MARK: - Overridden methods
    override func loadView() {
        view = checkEmailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        checkEmailView.delegate = self
    }

    // MARK: - Private methods
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

