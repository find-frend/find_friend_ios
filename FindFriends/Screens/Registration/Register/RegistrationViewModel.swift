//
//  RegistrationViewModel.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//
import Combine
import Foundation

final class RegistrationViewModel {
    @Published var allFieldsAreFilling = false
    @Published var personalIsFilling = false
    @Published var passwordIsFilling = false
 
    @Published var name = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
   
    private let textValidator = TextValidator()
    
    init() {
        let personal = Publishers.CombineLatest3($name, $lastName, $email)
        let password = Publishers.CombineLatest($password, $confirmPassword)
        
        personal
            .map {
                !$0.0.isEmpty &&
                !$0.1.isEmpty &&
                !$0.2.isEmpty
            }
            .assign(to: &$personalIsFilling)
        
        password
            .map {
                !$0.0.isEmpty && !$0.1.isEmpty
            }
            .assign(to: &$passwordIsFilling)
        
        $personalIsFilling.combineLatest($passwordIsFilling)
            .map { $0.0 && $0.1 }
            .assign(to: &$allFieldsAreFilling)
            
    }
}
