//
//  NewPasswordViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit


// MARK: - NewPasswordViewController
final class NewPasswordViewController: UIViewController {

    // MARK: - Private properties
    private let newPasswordView: NewPasswordView
    private var viewModel: NewPasswordViewModelProtocol

    // MARK: - Initializers
    init(
        viewModel: NewPasswordViewModelProtocol = NewPasswordViewModel(),
        newPasswordView: NewPasswordView = NewPasswordView()
    ) {
        self.viewModel = viewModel
        self.newPasswordView = newPasswordView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = newPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        hideKeyboardWhenTappedAround()
        bind()
        newPasswordView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Новый пароль"
    }

    private func bind() {
        viewModel.onSavePasswordAllowedStateChange = { [weak self] isAllowed in
            self?.newPasswordView.setSavePasswordButton(enabled: isAllowed)
        }
        viewModel.onPasswordErrorStateChange = { [weak self] message in
            self?.newPasswordView.setPasswordTextFieldError(message: message)
        }
        viewModel.onPasswordConfirmationErrorStateChange = { [weak self] message in
            self?.newPasswordView.setPasswordConfirmationTextFieldError(message: message)
        }
    }

    private func savePassword() {
        // TODO: request
        let viewController = NewPasswordSuccessViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - NewPasswordViewDelegate
extension NewPasswordViewController: NewPasswordViewDelegate {

    func didChangeTextField() {
        viewModel.newPasswordModel = newPasswordView.newPasswordModel
    }

    func didTapSavePasswordButton() {
        let isFieldsValid = viewModel.validateFields()
        if isFieldsValid {
            savePassword()
        }
    }

}
