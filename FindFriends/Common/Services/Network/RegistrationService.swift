//
//  RegistrationService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

// MARK: - RegistrationServiceProtocol
protocol RegistrationServiceProtocol {
    func createUser(
        _ dto: CreateUserRequestDto,
        completion: @escaping (Result<CreateUserResponseDto, Error>) -> Void
    )
    func loginUser(
        _ dto: LoginRequestDto,
        completion: @escaping (Result<LoginResponseDto, Error>) -> Void
    )
}

// MARK: - RegistrationService
final class RegistrationService: RegistrationServiceProtocol {

    // MARK: - Private  properties
    private let networkClient: NetworkClient
    private let oAuthTokenStorage: OAuthTokenStorageProtocol

    // MARK: - Initializers
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        oAuthTokenStorage: OAuthTokenStorageProtocol = OAuthTokenStorage.shared
    ) {
        self.networkClient = networkClient
        self.oAuthTokenStorage = oAuthTokenStorage
    }

    // MARK: - Public methods
    func createUser(
        _ dto: CreateUserRequestDto,
        completion: @escaping (Result<CreateUserResponseDto, Error>) -> Void
    ) {
        let request = CreateUserRequest(dto: dto)
        networkClient.send(request: request, type: CreateUserResponseDto.self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

    func loginUser(
        _ dto: LoginRequestDto,
        completion: @escaping (Result<LoginResponseDto, Error>) -> Void
    ) {
        let request = LoginUserRequest(dto: dto)
        networkClient.send(request: request, type: LoginResponseDto.self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.oAuthTokenStorage.token = data.authToken
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

}
