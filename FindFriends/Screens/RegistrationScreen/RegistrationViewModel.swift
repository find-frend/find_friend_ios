//
//  RegistrationViewModel.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//
import Combine
import Foundation
import SafariServices

final class RegistrationViewModel {
   
    let registrationService: RegistrationServiceProtocol
    
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
    
    @Published var webPage: SFSafariViewController?
    @Published var alert: AlertModel?
    
    private var allFieldsAreValidate: Bool {
        errorTextForName.isEmpty &&
        errorTextForLastName.isEmpty &&
        errorTextForEmail.isEmpty &&
        errorTextForPassword.isEmpty &&
        errorTextForConfirmPassword.isEmpty
    }
    
    init(registrationService: RegistrationServiceProtocol) {
        self.registrationService = registrationService
        setupPipline()
    }
    
    func registrationButtonTapped() {
        validateFields()
        if allFieldsAreValidate {
            let user = CreateUserRequestDto(firstName: name, lastName: lastName, email: email, password: confirmPassword)
            UIBlockingProgressHUD.show()
            registrationService.createUser(user) { [unowned self] result in
                switch result {
                case .success(_):
                    registrationService.loginUser(
                        LoginRequestDto(email: email, password: confirmPassword)) { [unowned self] _ in
                            switchToGenderScreen()
                        }
                case .failure(let error):
                    showAlert(error)
                }
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func agreementDidTapped() {
        guard let url = URL(string: "https://practicum.yandex.ru") else { return }
        let webPage = SFSafariViewController(url: url)
        self.webPage = webPage
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
    
    private func validateFields() {
        switch ValidationService.validate(name, type: .name) {
        case .success(_):
            errorTextForName = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForName = message.rawValue
        }
        
        switch ValidationService.validate(lastName, type: .lastName) {
        case .success(_):
            errorTextForLastName = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForLastName = message.rawValue
        }
        
        switch ValidationService.validate(email, type: .email) {
        case .success(_):
            errorTextForEmail = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForEmail = message.rawValue
        }
        
        switch ValidationService.validate(password, type: .password) {
        case .success(_):
            errorTextForPassword = ValidateMessages.emptyMessage.rawValue
        case .failure(let message):
            errorTextForPassword = message.rawValue
        }
        
        if password != confirmPassword {
            errorTextForConfirmPassword = ValidateMessages.passwordsNotEqual.rawValue
        } else {
            switch ValidationService.validate(confirmPassword, type: .confirmPassword) {
            case .success(_):
                errorTextForConfirmPassword = ValidateMessages.emptyMessage.rawValue
            case .failure(let message):
                errorTextForConfirmPassword = message.rawValue
            }
        }
    }
    
    private func showAlert(_ error: NetworkClientError) {
        let description = checkError(error)
        
        let alert = AlertModel(
            title: "Внимание",
            message: description,
            buttons: [AlertButton(
                text: "Понятно",
                style: .cancel,
                completion: { _ in })
            ],
            preferredStyle: .alert
        )
        self.alert = alert
    }
    
    private func switchToGenderScreen() {
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = scene.windows.first
        else { fatalError("Invalid Configuration") }
        
        let fillProfile = CustomUIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        window.rootViewController = fillProfile
    }
    
    private func checkError(_ error: NetworkClientError) -> String {
        var description = ""
        
        switch error {
        case let .httpStatusCode(_, data):
            let model = try? JSONDecoder().decode(RegistrationErrorModel.self, from: data)
            description = model?.currentError ?? ""
        case .urlRequestError(let error):
            assertionFailure("Ошибка составления запроса: \(error.localizedDescription)")
        case .urlSessionError:
            assertionFailure("Непредвиденная ошибка")
        case .parsingError:
            assertionFailure("Ошибка парсинга")
        }
        
        return description
    }
}