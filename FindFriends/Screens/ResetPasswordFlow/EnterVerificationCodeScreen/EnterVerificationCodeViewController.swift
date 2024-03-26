//
//  EnterVerificationCodeViewController.swift
//  FindFriends
//
//  Created by Вадим Шишков on 22.03.2024.
//

import UIKit

final class EnterVerificationCodeViewController: BaseRegistrationViewController {
    private let enterVerficationCodeView: EnterVerificationCodeView
    private let service = RegistrationService()
    
    override func loadView() {
        self.view = enterVerficationCodeView
    }
    
    init(enterVerficationCodeView: EnterVerificationCodeView) {
        self.enterVerficationCodeView = enterVerficationCodeView
        super.init(baseRegistrationView: BaseRegistrationView())
        
        setupNavigationItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Верификация"
        navigationItem.backButtonTitle = "Назад"
    }
}

extension EnterVerificationCodeViewController: EnterVerificationViewDelegate {
    func showNewPasswordScreen(_ token: String) {
        let viewModel = NewPasswordViewModel(token: token)
        let view = NewPasswordView(viewModel: viewModel)
        let viewController = NewPasswordViewController(newPasswordView: view)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlert(_ message: String) {
        let alert = AlertModel(message: message)
        AlertPresenter.show(in: self, model: alert)
    }
}
