//
//  LoginViewModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

protocol LoginViewModelProtocol {
    var onLoginAllowedStateChange: Binding<Bool>? { get set }
    var onEmailErrorStateChange: Binding<String>? { get set }
    var onPasswordErrorStateChange: Binding<String>? { get set }
    var credentials: Credentials { get set }

    func loginUser(completion: @escaping (Result<LoginResponseDto, Error>) -> Void)
    func validateFields() -> Bool
}

final class LoginViewModel: LoginViewModelProtocol {

    var onLoginAllowedStateChange: Binding<Bool>?
    var onEmailErrorStateChange: Binding<String>?
    var onPasswordErrorStateChange: Binding<String>?

    var credentials: Credentials {
        didSet {
            let allFieldsAreFilled = !credentials.email.isEmpty && !credentials.password.isEmpty
            onLoginAllowedStateChange?(allFieldsAreFilled)
            hideErrorMessages()
        }
    }

    private let registrationService: RegistrationServiceProtocol

    init(
        registrationService: RegistrationServiceProtocol = RegistrationService(),
        credentials: Credentials = Credentials.empty
    ) {
        self.registrationService = registrationService
        self.credentials = credentials
    }

    func loginUser(completion: @escaping (Result<LoginResponseDto, Error>) -> Void) {
        registrationService.loginUser(credentials.toLoginRequestDto) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func validateFields() -> Bool {
        let isLoginValid = validateLogin()
        let isPasswordValid = validatePassword()
        return isLoginValid && isPasswordValid
    }

    private func validateLogin() -> Bool {
        switch ValidationService.validate(credentials.email, type: .email) {
        case .success:
            onEmailErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
            return true
        case .failure(let message):
            onEmailErrorStateChange?(message.rawValue)
            return false
        }
    }

    private func validatePassword() -> Bool {
        switch ValidationService.validate(credentials.password, type: .password) {
        case .success:
            onPasswordErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
            return true
        case .failure(let message):
            onPasswordErrorStateChange?(message.rawValue)
            return false
        }
    }

    private func hideErrorMessages() {
        onEmailErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
        onPasswordErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
    }
}
