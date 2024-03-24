//
//  ResetPasswordViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit

final class ResetPasswordViewController: BaseRegistrationViewController {
    private let resetPasswordView: ResetPasswordView
    private var viewModel: ResetPasswordViewModelProtocol

    init(
        viewModel: ResetPasswordViewModelProtocol = ResetPasswordViewModel(),
        resetPasswordView: ResetPasswordView = ResetPasswordView()
    ) {
        self.viewModel = viewModel
        self.resetPasswordView = resetPasswordView
        super.init(baseRegistrationView: resetPasswordView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = resetPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        bind()
        resetPasswordView.delegate = self
    }

    private func bind() {
        viewModel.onResetAllowedStateChange = { [weak self] isResetAllowed in
            self?.resetPasswordView.setSendInstructionButton(enabled: isResetAllowed)
        }
        viewModel.onEmailErrorStateChange = { [weak self] message in
            self?.resetPasswordView.setEmailTextFieldError(message: message)
        }
    }

    private func configureNavigationBar() {
        navigationItem.title = "Сброс пароля"
    }

    private func sendInstruction() {
        UIBlockingProgressHUD.show()
        self.viewModel.resetPassword { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                UIBlockingProgressHUD.dismiss()
                
                let viewModel = EnterVerificationCodeViewModel(email: viewModel.email, service: RegistrationService())
                let view = EnterVerificationCodeView(viewModel: viewModel)
                let viewController = EnterVerificationCodeViewController(enterVerficationCodeView: view)
                
                self.navigationController?.pushViewController(viewController, animated: true)
                
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                AlertPresenter.show(in: self, model: AlertModel(message: error.message))
            }
        }
    }
}

// MARK: - ResetPasswordViewDelegate

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
