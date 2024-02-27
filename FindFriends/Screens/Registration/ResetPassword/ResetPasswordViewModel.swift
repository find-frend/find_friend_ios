//
//  ResetPasswordViewModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 27.02.2024.
//

import Foundation

// MARK: - ResetPasswordViewModelProtocol
protocol ResetPasswordViewModelProtocol {
    var onResetAllowedStateChange: Binding<Bool>? { get set }
    var onEmailErrorStateChange: Binding<String>? { get set }
    var email: String { get set }

    func validateEmail() -> Bool
}

// MARK: - ResetPasswordViewModel
final class ResetPasswordViewModel: ResetPasswordViewModelProtocol {

    // MARK: - Public properties
    var onResetAllowedStateChange: Binding<Bool>?
    var onEmailErrorStateChange: Binding<String>?

    var email: String = "" {
        didSet {
            onResetAllowedStateChange?(!email.isEmpty)
            onEmailErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
        }
    }

    // MARK: - Private properties
    private let registrationService: RegistrationServiceProtocol

    // MARK: - Initializers
    init(registrationService: RegistrationServiceProtocol = RegistrationService()) {
        self.registrationService = registrationService
    }

    // MARK: - Public methods
    func validateEmail() -> Bool {
        switch TextValidator.validate(email, with: .email) {
        case .success:
            onEmailErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
            return true
        case .failure(let message):
            onEmailErrorStateChange?(message.rawValue)
            return false
        }
    }

}
