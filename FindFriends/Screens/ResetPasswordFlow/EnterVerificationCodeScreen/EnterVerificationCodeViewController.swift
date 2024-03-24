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

