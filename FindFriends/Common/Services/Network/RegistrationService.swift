//
//  RegistrationService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

protocol RegistrationServiceProtocol {
    func createUser(
        _ dto: CreateUserRequestDto,
        completion: @escaping (Result<CreateUserResponseDto, NetworkClientError>) -> Void
    )
    func loginUser(
        _ dto: LoginRequestDto,
        completion: @escaping (Result<LoginResponseDto, NetworkClientError>) -> Void
    )
    func resetPassword(
        _ dto: ResetPasswordRequestDto,
        completion: @escaping (Result<ResetPasswordResponseDto, NetworkClientError>) -> Void
    )
    func setNewPassword(
        _ dto: NewPasswordDto,
        completion: @escaping (Result<NewPasswordDto, NetworkClientError>) -> Void
    )
}

final class RegistrationService: RegistrationServiceProtocol {

    private let networkClient: NetworkClient
    private let oAuthTokenStorage: OAuthTokenStorageProtocol

    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        oAuthTokenStorage: OAuthTokenStorageProtocol = OAuthTokenStorage.shared
    ) {
        self.networkClient = networkClient
        self.oAuthTokenStorage = oAuthTokenStorage
    }

    func createUser(
        _ dto: CreateUserRequestDto,
        completion: @escaping (Result<CreateUserResponseDto, NetworkClientError>) -> Void
    ) {
        let request = UsersRequest(httpMethod: .post, dto: dto)
        networkClient.send(request: request, type: CreateUserResponseDto.self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(user):
                    completion(.success(user))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

    func loginUser(
        _ dto: LoginRequestDto,
        completion: @escaping (Result<LoginResponseDto, NetworkClientError>) -> Void
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

    func resetPassword(
        _ dto: ResetPasswordRequestDto,
        completion: @escaping (Result<ResetPasswordResponseDto, NetworkClientError>) -> Void
    ) {
        let request = ResetPasswordRequest(dto: dto)
        networkClient.send(request: request, type: ResetPasswordResponseDto.self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    completion(.success(response))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

    func setNewPassword(
        _ dto: NewPasswordDto,
        completion: @escaping (Result<NewPasswordDto, NetworkClientError>) -> Void
    ) {
        let request = NewPasswordRequest(dto: dto)
        networkClient.send(request: request, type: NewPasswordDto.self) { result in
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
}
