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
    
    @Published var errorTextForName = ""
    @Published var errorTextForLastName = ""
    @Published var errorTextForEmail = ""
    @Published var errorTextForPassword = ""
    @Published var errorTextForConfirmPassword = ""
    
    init() {
        setupPipline()
    }
    
    func registrationButtonTapepd() {
        if let nameError = TextValidator.validate(name, with: .name) {
            errorTextForName = nameError
        } else {
            errorTextForName = ""
        } 
        
        if let lastNameError = TextValidator.validate(lastName, with: .lastName) {
            errorTextForLastName = lastNameError
        } else {
            errorTextForLastName = ""
        }
        
        if let emailError = TextValidator.validate(email, with: .email) {
            errorTextForEmail = emailError
        } else {
            errorTextForEmail = ""
        }  
        
        if let passwordError = TextValidator.validate(password, with: .password) {
            errorTextForPassword = passwordError
        } else {
            errorTextForPassword = ""
        }
        
        if password != confirmPassword {
            errorTextForConfirmPassword = "Пароли не совпадают"
        } else {
            if let confirmPasswordError = TextValidator.validate(confirmPassword, with: .confirmPassword) {
                errorTextForConfirmPassword = confirmPasswordError
            } else {
                errorTextForConfirmPassword = ""
            }
        }
    }
    
    private func setupPipline() {
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
