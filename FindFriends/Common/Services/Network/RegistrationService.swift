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
        let request = UsersRequest(httpMethod: .post, body: dto)
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
        let request = LoginUserRequest(body: dto)
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
