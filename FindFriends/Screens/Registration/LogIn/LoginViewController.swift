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
final class LoginViewController: UIViewController {

    // MARK: - Public properties
    weak var delegate: LoginViewControllerDelegate?

    // MARK: - Private properties
    private let loginView: LoginView
    private let viewModel: LoginViewModelProtocol

    // MARK: - Initializers
    init(
        viewModel: LoginViewModelProtocol = LoginViewModel(),
        loginView: LoginView = LoginView()
    ) {
        self.viewModel = viewModel
        self.loginView = loginView
        super.init(nibName: nil, bundle: nil)
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
        hideKeyboardWhenTappedAround()
        loginView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Вход"
        navigationItem.backButtonTitle = "Назад"
        navigationItem.largeTitleDisplayMode = .always
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
        UIBlockingProgressHUD.show()
        viewModel.loginUser(model: loginView.model) { [weak self] result in
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

    func didTapForgotPasswordButton() {
        let viewController = ResetPasswordViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}
