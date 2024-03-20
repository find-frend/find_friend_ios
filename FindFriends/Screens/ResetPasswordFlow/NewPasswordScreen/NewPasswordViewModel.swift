//
//  NewPasswordViewModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 27.02.2024.
//

import Foundation

protocol NewPasswordViewModelProtocol {
    var onSavePasswordAllowedStateChange: Binding<Bool>? { get set }
    var onPasswordErrorStateChange: Binding<String>? { get set }
    var onPasswordConfirmationErrorStateChange: Binding<String>? { get set }
    var newPasswordModel: NewPasswordModel { get set }

    func setNewPassword(completion: @escaping (Result<NewPasswordDto, Error>) -> Void)
    func validateFields() -> Bool
}

final class NewPasswordViewModel: NewPasswordViewModelProtocol {
    var onSavePasswordAllowedStateChange: Binding<Bool>?
    var onPasswordErrorStateChange: Binding<String>?
    var onPasswordConfirmationErrorStateChange: Binding<String>?

    var newPasswordModel: NewPasswordModel {
        didSet {
            let allFieldsAreFilled = !newPasswordModel.password.isEmpty
                                  && !newPasswordModel.passwordConfirmation.isEmpty
            onSavePasswordAllowedStateChange?(allFieldsAreFilled)
            hideErrorMessages()
        }
    }

    private let registrationService: RegistrationServiceProtocol

    init(
        registrationService: RegistrationServiceProtocol = RegistrationService(),
        newPasswordModel: NewPasswordModel = NewPasswordModel.empty
    ) {
        self.registrationService = registrationService
        self.newPasswordModel = newPasswordModel
    }

    func setNewPassword(completion: @escaping (Result<NewPasswordDto, Error>) -> Void) {
        // TODO: wait till backend be done
        let dto = NewPasswordDto(uid: "", token: "", new_password: newPasswordModel.password)
        registrationService.setNewPassword(dto) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func validateFields() -> Bool {
        let isPasswordValid = validatePassword()
        let isPasswordConfirmationValid = validatePasswordConfirmation()
        return isPasswordValid && isPasswordConfirmationValid
    }

    private func validatePassword() -> Bool {
        switch TextValidator.validate(newPasswordModel.password, with: .password) {
        case .success:
            onPasswordErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
            return true
        case .failure(let message):
            onPasswordErrorStateChange?(message.rawValue)
            return false
        }
    }

    private func validatePasswordConfirmation() -> Bool {
        if newPasswordModel.password != newPasswordModel.passwordConfirmation {
            onPasswordConfirmationErrorStateChange?(ValidateMessages.passwordsNotEqual.rawValue)
            return false
        }
        switch TextValidator.validate(newPasswordModel.passwordConfirmation, with: .confirmPassword) {
        case .success(_):
            onPasswordConfirmationErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
            return true
        case .failure(let message):
            onPasswordConfirmationErrorStateChange?(message.rawValue)
            return false
        }
    }

    private func hideErrorMessages() {
        onPasswordErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
        onPasswordConfirmationErrorStateChange?(ValidateMessages.emptyMessage.rawValue)
    }
}

