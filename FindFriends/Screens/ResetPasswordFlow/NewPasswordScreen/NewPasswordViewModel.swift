//
//  NewPasswordViewModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 27.02.2024.
//

import Foundation

final class NewPasswordViewModel {
    @Published var fieldsAreFilling = false
    @Published var errorForPassword = ""
    @Published var errorForConfirmPassword = ""
    @Published var isSuccess = false
    @Published var isLoading = false
    var password = ""
    var confirmPassword = ""
    let token: String

    private let resetPasswordService: ResetPasswordServiceProtocol

    init(
        resetPasswordService: ResetPasswordServiceProtocol = ResetPasswordService(),
        token: String
    ) {
        self.resetPasswordService = resetPasswordService
        self.token = token
    }
    
    func saveButtonTapped() {
        if validateFields() {
            isLoading = true
            let dto = NewPasswordDto(token: token, password: confirmPassword)
            resetPasswordService.setNewPassword(dto) { [unowned self] result in
                switch result {
                case .success(let model):
                    isSuccess = true
                case .failure(let error):
                    isSuccess = false
                }
                isLoading = false
            }
        }
    }
    
    func textFieldsDidChanged(_ password: String?,_ confirmPassword: String?) {
        guard let password,
              let confirmPassword else { return }
        self.password = password
        self.confirmPassword = confirmPassword
        fieldsAreFilling = !password.isEmpty && !confirmPassword.isEmpty
    }
    
    private func validateFields() -> Bool {
        let isPasswordValid = validatePassword()
        let isPasswordConfirmationValid = validatePasswordConfirmation()
        return isPasswordValid && isPasswordConfirmationValid
    }

    private func validatePassword() -> Bool {
        switch ValidationService.validate(password, type: .password) {
        case .success:
            errorForPassword = ValidateMessages.emptyMessage.rawValue
            return true
        case .failure(let message):
            errorForPassword = message.rawValue
            return false
        }
    }

    private func validatePasswordConfirmation() -> Bool {
        if password != confirmPassword {
            errorForConfirmPassword = ValidateMessages.passwordsNotEqual.rawValue
            return false
        }
        switch ValidationService.validate(confirmPassword, type: .confirmPassword) {
        case .success(_):
            errorForConfirmPassword = ValidateMessages.emptyMessage.rawValue
            return true
        case .failure(let message):
            errorForConfirmPassword = message.rawValue
            return false
        }
    }
}

