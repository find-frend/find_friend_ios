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
    @Published var isFullfill = false
    
    var fields: [CurrentValueSubject<String, Never>] = [
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>(""),
        CurrentValueSubject<String, Never>("")
    ]
    
    private let service: RegistrationServiceProtocol
    private var code = Array(repeating: "", count: 6)
    private var cancellables: Set<AnyCancellable> = []
    
    init(email: String, service: RegistrationServiceProtocol) {
        self.email = email
        self.service = service
        bind()
    }
    
    func sendCodeAgainButtonTapped() {
        let dto = ResetPasswordRequestDto(email: email)
        service.resetPassword(dto) {_ in}
    }
    
    func confirmButtonTapped() {
        
    }
    
    private func bind() {
        for field in fields.enumerated() {
            field.element
                .drop { $0.count > 1 }
                .sink { [unowned self] num in
                    code[field.offset] = num
                    checkCode()
                }
                .store(in: &cancellables)
        }
    }
    
    private func checkCode() {
        isFullfill = code.allSatisfy { !$0.isEmpty }
    }
}
