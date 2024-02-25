//
//  UserNetworkService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct LoginUserRequest: NetworkRequest {
    
    var token: String = ""
    var httpMethod: HttpMethod = .post
    var endpoint: URL? = URL(string: "http://213.189.221.246/api/v1/auth/token/login/")
    var dto: Encodable? // = LoginRequestDto(password: "4379dfdfd44", email: "ert3@gmail.com")
}

struct CreateUserRequest: NetworkRequest {
    var token: String = ""
    var httpMethod: HttpMethod = .post
    var endpoint: URL? = URL(string: "http://213.189.221.246/api/v1/users/")
    var dto: Encodable? //= CreateUserRequestDto(first_name: "User1", last_name: "1User", email: "ert3@gmail.com", password: "4379dfdfd44")
}

protocol UsersServiceProviderProtocol {
    func createUser(first_name: String, 
                    last_name: String,
                    email: String, 
                    password: String,
                    _ completion: @escaping (Result<CreateUserResponceDto, Error>) -> Void)
    func userLogin( email: String, 
                    password: String,
                    _ completion: @escaping (Result<LoginResponceDto, Error>) -> Void)
}

final class UsersServiceProvider: UsersServiceProviderProtocol {

    let networkClient: NetworkClient
    private let oAuthTokenStorage = OAuthTokenStorage()

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    /// Функция функция возвразает список друзей у текущего пользователя
    func createUser(first_name: String, last_name: String, email: String, password: String, _ completion: @escaping (Result<CreateUserResponceDto, Error>) -> Void) {
        let createUserRequest = CreateUserRequest(dto:  CreateUserRequestDto(first_name: first_name, last_name: last_name, email: email, password: password))
        networkClient.send(request: createUserRequest , type: CreateUserResponceDto.self)  { result in
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
        
    /// Функция функция возвразает список друзей у текущего пользователя
    func userLogin( email: String, password: String, _ completion: @escaping (Result<LoginResponceDto, Error>) -> Void) {
        let createUserRequest = LoginUserRequest( dto: LoginRequestDto(password: password, email: email))
        networkClient.send(request: createUserRequest , type: LoginResponceDto.self)  { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.oAuthTokenStorage.token = data.auth_token
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    

}
