//
//  ResetPasswordService.swift
//  FindFriends
//
//  Created by Вадим Шишков on 25.03.2024.
//

import Foundation

protocol ResetPasswordServiceProtocol {
    func resetPassword(
        _ dto: ResetPasswordRequestDto,
        completion: @escaping (Result<ResetPasswordResponseDto, NetworkClientError>) -> Void
    )
    func setNewPassword(
        _ dto: NewPasswordDto,
        completion: @escaping (Result<NewPasswordDto, NetworkClientError>) -> Void
    )
}

final class ResetPasswordService: ResetPasswordServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
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
    
    func confirmPassword(
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
