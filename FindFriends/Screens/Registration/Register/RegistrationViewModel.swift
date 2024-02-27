//
//  RegistrationViewModel.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//
import Combine
import Foundation
import SafariServices

final class RegistrationViewModel {
   
    @Published var allFieldsAreFilling = false
    @Published var personalIsFilling = false
    @Published var passwordIsFilling = false
 
    @Published var name = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var errorTextForName = ""
    @Published var errorTextForLastName = ""
    @Published var errorTextForEmail = ""
    @Published var errorTextForPassword = ""
    @Published var errorTextForConfirmPassword = ""
    
    @Published var webPage: SFSafariViewController?
    
    private var allFieldsAreValidate: Bool {
        errorTextForName.isEmpty &&
        errorTextForLastName.isEmpty &&
        errorTextForEmail.isEmpty &&
        errorTextForPassword.isEmpty &&
        errorTextForConfirmPassword.isEmpty
    }
    
    init() {
        setupPipline()
    }
    
    func registrationButtonTapped() {
        validateFields()
        if allFieldsAreValidate {
            print("ушел запрос в сеть")
        }
    }
    
    func agreementDidTapped() {
        guard let url = URL(string: "https://practicum.yandex.ru") else { return }
        let webPage = SFSafariViewController(url: url)
        self.webPage = webPage
    }
    
    private func setupPipline() {
        let personal = Publishers.CombineLatest3($name, $lastName, $email)
        let password = Publishers.CombineLatest($password, $confirmPassword)
        
        personal
            .map {
                !$0.0.isEmpty &&
                !$0.1.isEmpty &&
                !$0.2.isEmpty
            }
            .assign(to: &$personalIsFilling)
        
        password
            .map {
                !$0.0.isEmpty && !$0.1.isEmpty
            }
            .assign(to: &$passwordIsFilling)
        
        $personalIsFilling.combineLatest($passwordIsFilling)
            .map { $0.0 && $0.1 }
            .assign(to: &$allFieldsAreFilling)
    }
    
    private func validateFields() {
        switch TextValidator.validate(name, with: .name) {
        case .success(_):
            errorTextForName = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForName = message.rawValue
        }
        
        switch TextValidator.validate(lastName, with: .lastName) {
        case .success(_):
            errorTextForLastName = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForLastName = message.rawValue
        }
        
        switch TextValidator.validate(email, with: .email) {
        case .success(_):
            errorTextForEmail = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForEmail = message.rawValue
        }
        
        switch TextValidator.validate(password, with: .password) {
        case .success(_):
            errorTextForPassword = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForPassword = message.rawValue
        }
        
        if password != confirmPassword {
            errorTextForConfirmPassword = ValidateMessages.passwordsNotEqual.rawValue
        } else {
            switch TextValidator.validate(confirmPassword, with: .confirmPassword) {
            case .success(_):
                errorTextForConfirmPassword = ValidateMessages.emptyMessage.rawValue
            case .failure(let message):
                errorTextForConfirmPassword = message.rawValue
            }
        }
    }
}
