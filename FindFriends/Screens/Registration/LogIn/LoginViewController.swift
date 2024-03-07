//
//  LoginViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 20.02.2024.
//

import UIKit

// MARK: - LoginViewControllerDelegate
protocol LoginViewControllerDelegate: AnyObject {
    func didAuthenticate()
}

// MARK: - LoginViewController
final class LoginViewController: BaseRegistrationViewController {

    // MARK: - Public properties
    weak var delegate: LoginViewControllerDelegate?

    // MARK: - Private properties
    private let loginView: LoginView
    private var viewModel: LoginViewModelProtocol

    // MARK: - Initializers
    init(
        viewModel: LoginViewModelProtocol = LoginViewModel(),
        loginView: LoginView = LoginView()
    ) {
        self.viewModel = viewModel
        self.loginView = loginView
        super.init(baseRegistrationView: loginView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        bind()
        loginView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Вход"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.largeTitleDisplayMode = .always
    }

    private func bind() {
        viewModel.onLoginAllowedStateChange = { [weak self] isLoginAllowed in
            self?.loginView.setLoginButton(enabled: isLoginAllowed)
        }
        viewModel.onEmailErrorStateChange = { [weak self] message in
            self?.loginView.setEmailTextFieldError(message: message)
        }
        viewModel.onPasswordErrorStateChange = { [weak self] message in
            self?.loginView.setPasswordTextFieldError(message: message)
        }
    }

    private func loginUser() {
        UIBlockingProgressHUD.show()
        self.viewModel.loginUser { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                UIBlockingProgressHUD.dismiss()
                self.delegate?.didAuthenticate()
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                AlertPresenter.show(
                    in: self,
                    model: .loginError(message: error.localizedDescription)
                )
            }
        }
    }

}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {

    func didChangeTextField() {
        viewModel.credentials = loginView.credentials
    }

    func didTapRegistrationButton() {
        let view = RegistrationView()
        let viewController = RegistrationViewController(registrationView: view)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func didTapLoginButton() {
        let isFieldsValid = viewModel.validateFields()
        if isFieldsValid {
            loginUser()
        }
    }

    func didTapForgotPasswordButton() {
        let viewController = ResetPasswordViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}
