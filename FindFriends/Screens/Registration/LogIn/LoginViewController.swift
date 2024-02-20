//
//  LoginViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 20.02.2024.
//

import UIKit


// MARK: - LoginViewController
final class LoginViewController: UIViewController {

    // MARK: - Private properties
    private let loginView = LoginView()

    // MARK: - Overridden methods
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        hideKeyboardWhenTappedAround()
        loginView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Вход"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", 
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }

}


// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {

    func didTapRegistrationButton() {
        let view = RegistrationView()
        let viewController = RegistrationViewController(registrationView: view)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func didTapLoginButton() {
        // TODO: handle action
        print("didTapLoginButton")
    }

    func didTapForgotPasswordButton() {
        // TODO: handle action
        print("didTapForgotPasswordButton")
    }

}
