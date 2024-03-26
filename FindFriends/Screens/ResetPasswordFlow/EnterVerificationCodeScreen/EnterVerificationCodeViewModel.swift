//
//  EnterVerificationCodeViewModel.swift
//  FindFriends
//
//  Created by Вадим Шишков on 22.03.2024.
//

import Foundation
import Combine

final class EnterVerificationCodeViewModel {
    let email: String
    var token = Array(repeating: "", count: 6)
    @Published var isFullfill = false
    @Published var tokenIsValid = false
    @Published var error: NetworkClientError?
    @Published var isLoading = false 
    
    var fields: [CurrentValueSubject<String, Never>] = [
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>("")
    ]
    
    private let service: ResetPasswordServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(email: String, service: ResetPasswordServiceProtocol) {
        self.email = email
        self.service = service
        bind()
    }
    
    func sendCodeAgainButtonTapped() {
        let dto = ResetPasswordRequestDto(email: email)
        service.resetPassword(dto) {_ in}
    }
    
    func confirmButtonTapped() {
        isLoading = true
        service.validateCode(token.joined()) { [unowned self] result in
            switch result {
            case .success(_):
                tokenIsValid = true
            case .failure(let error):
                self.error = error
            }
            isLoading = false
        }
    }
    
    private func bind() {
        for field in fields.enumerated() {
            field.element
                .drop { $0.count > 1 }
                .sink { [unowned self] num in
                    token[field.offset] = num
                    checkCode()
                }
                .store(in: &cancellables)
        }
    }
    
    private func checkCode() {
        isFullfill = token.allSatisfy { !$0.isEmpty }
    }
}
