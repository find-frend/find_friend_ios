//
//  ResetPasswordViewModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 27.02.2024.
//

import Foundation

protocol ResetPasswordViewModelProtocol {
    var onResetAllowedStateChange: Binding<Bool>? { get set }
    var onEmailErrorStateChange: Binding<String>? { get set }
    var email: String { get set }

    func resetPassword(completion: @escaping (Result<Void, NetworkClientError>) -> Void)
    func validateEmail() -> Bool
}

final class ResetPasswordViewModel: ResetPasswordViewModelProtocol {

    var onResetAllowedStateChange: Binding<Bool>?
    var onEmailErrorStateChange: Binding<String>?

    var email: String = "" {
        didSet {
            onResetAllowedStateChange?(!email.isEmpty)
            onEmailErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
        }
    }

    private let registrationService: RegistrationServiceProtocol

    init(registrationService: RegistrationServiceProtocol = RegistrationService()) {
        self.registrationService = registrationService
    }

    func resetPassword(completion: @escaping (Result<Void, NetworkClientError>) -> Void) {
        registrationService.resetPassword(ResetPasswordDto(email: email)) { result in
            switch result {
            case .success(let model):
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func validateEmail() -> Bool {
        switch ValidationService.validate(email, type: .email) {
        case .success:
            onEmailErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
            return true
        case .failure(let message):
            onEmailErrorStateChange?(message.rawValue)
            return false
        }
    }
}
