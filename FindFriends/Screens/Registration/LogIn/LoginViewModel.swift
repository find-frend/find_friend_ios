//
//  LoginViewModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

// MARK: - LoginViewModelProtocol
protocol LoginViewModelProtocol {
    func loginUser(
        model: LoginModel,
        completion: @escaping (Result<LoginResponseDto, Error>) -> Void
    )
}

// MARK: - LoginViewModel
final class LoginViewModel: LoginViewModelProtocol {

    // MARK: - Private properties
    private let registrationService: RegistrationServiceProtocol

    // MARK: - Initializers
    init(registrationService: RegistrationServiceProtocol = RegistrationService()) {
        self.registrationService = registrationService
    }

    // MARK: - Public methods
    func loginUser(
        model: LoginModel,
        completion: @escaping (Result<LoginResponseDto, Error>) -> Void
    ) {
        registrationService.loginUser(model.toLoginRequestDto) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
