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
    private let resetPasswordView: ResetPasswordView
    private var viewModel: ResetPasswordViewModelProtocol

    // MARK: - Initializers
    init(
        viewModel: ResetPasswordViewModelProtocol = ResetPasswordViewModel(),
        loginView: ResetPasswordView = ResetPasswordView()
    ) {
        self.viewModel = viewModel
        self.resetPasswordView = loginView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = resetPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        hideKeyboardWhenTappedAround()
        bind()
        resetPasswordView.delegate = self
    }

    // MARK: - Public methods
    private func bind() {
        viewModel.onResetAllowedStateChange = { [weak self] isResetAllowed in
            self?.resetPasswordView.setSendInstructionButton(enabled: isResetAllowed)
        }
        viewModel.onEmailErrorStateChange = { [weak self] message in
            self?.resetPasswordView.setEmailTextFieldError(message: message)
        }
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Сброс пароля"
    }

    private func sendInstruction() {
        // TODO: request
        let viewController = CheckEmailViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - ResetPasswordViewController
extension ResetPasswordViewController: ResetPasswordViewDelegate {

    func didChangeTextField() {
        viewModel.email = resetPasswordView.email
    }

    func didTapSendInstructionButton() {
        let isEmailValid = viewModel.validateEmail()
        if isEmailValid {
            sendInstruction()
        }
    }

}
