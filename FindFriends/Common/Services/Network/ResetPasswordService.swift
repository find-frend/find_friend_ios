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
        completion: @escaping (Result<SuccessResponse, NetworkClientError>) -> Void
    )
    func validateCode(
        _ token: String,
        completion: @escaping (Result<Void, NetworkClientError>) -> Void
    )
    func setNewPassword(
        _ dto: NewPasswordDto,
        completion: @escaping (Result<Void, NetworkClientError>) -> Void
    )
}

final class ResetPasswordService: ResetPasswordServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func resetPassword(
        _ dto: ResetPasswordRequestDto,
        completion: @escaping (Result<SuccessResponse, NetworkClientError>) -> Void
    ) {
        let request = ResetPasswordRequest(body: dto)
        networkClient.send(request: request, type: SuccessResponse.self) { result in
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
    
    func validateCode(_ token: String, completion: @escaping (Result<Void, NetworkClientError>) -> Void) {
        let dto = TokenDto(token: token)
        let request = ValidateCodeRequest(body: dto)
        networkClient.send(request: request, type: SuccessResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success.status == "OK" {
                        completion(.success(Void()))
                    } else {
                        completion(.failure(.parsingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func setNewPassword(
        _ dto: NewPasswordDto,
        completion: @escaping (Result<Void, NetworkClientError>) -> Void
    ) {
        let request = NewPasswordRequest(body: dto)
        networkClient.send(request: request, type: SuccessResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(success):
                    if success.status == "OK" {
                        completion(.success(Void()))
                    } else {
                        completion(.failure(.parsingError))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
