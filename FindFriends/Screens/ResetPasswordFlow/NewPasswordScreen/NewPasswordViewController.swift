//
//  NewPasswordViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit

final class NewPasswordViewController: BaseRegistrationViewController {

    private let newPasswordView: NewPasswordView
    private var viewModel: NewPasswordViewModelProtocol

    init(
        viewModel: NewPasswordViewModelProtocol = NewPasswordViewModel(),
        newPasswordView: NewPasswordView = NewPasswordView()
    ) {
        self.viewModel = viewModel
        self.newPasswordView = newPasswordView
        super.init(baseRegistrationView: newPasswordView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = newPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        bind()
        newPasswordView.delegate = self
    }

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
        UIBlockingProgressHUD.show()
        self.viewModel.setNewPassword { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                UIBlockingProgressHUD.dismiss()
                let viewController = NewPasswordSuccessViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
//                AlertPresenter.show(
//                    in: self,
//                    model: .resetPasswordError(message: error.localizedDescription)
//                )
            }
        }
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
