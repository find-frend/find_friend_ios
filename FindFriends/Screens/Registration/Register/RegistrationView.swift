//
//  RegistrationView.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import Combine
import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func backToLogInScreen()
}

final class RegistrationView: UIView {
    let viewModel = RegistrationViewModel()
    weak var delegate: RegistrationViewDelegate?
    
    let nameTextField: RegistrationTextField = {
        let textField = RegistrationTextField( placeholder: "Имя", type: .personal)
        textField.addTarget(self, action: #selector(nameDidChange), for: .editingChanged)
        return textField
    }()
    
    let lastnameTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Фамилия", type: .personal)
        textField.addTarget(self, action: #selector(lastNameDidChange), for: .editingChanged)
        return textField
    }()
    
    let emailTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Электронная почта", type: .email)
        textField.addTarget(self, action: #selector(emailDidChange), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Пароль", type: .password)
        textField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        return textField
    }()  
    
    let passwordConfirmationTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Повторите пароль", type: .confirmPassword)
        textField.addTarget(self, action: #selector(confirmPasswordDidChange), for: .editingChanged)
        return textField
    }()
    
    
    let registrationButton = PrimeOrangeButton(text: "Зарегистрироваться")
    let enterButton = CaptionButton(text: "Войти")
    
    let agreementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let text = NSMutableAttributedString(
            string: "Создавая учетную запись, вы принимаете\nУсловия использования"
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        text.addAttributes(
            [
                .font: UIFont.systemFont(ofSize: 13, weight: .regular),
                .foregroundColor: UIColor.primeDark,
                .paragraphStyle: paragraphStyle
            ],
            range: NSRange(location: 0, length: text.length)
        )
        
        text.addAttribute(.underlineStyle, value: 1, range: NSRange(location: 39, length: 21))
        
        label.attributedText = text
        return label
    }()
    
    private lazy var topDecoration: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .topDecoration)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.$allFieldsAreFilling
            .assign(to: \.isEnabled, on: registrationButton)
            .store(in: &cancellables)
        
        viewModel.$allFieldsAreFilling
            .sink { [weak self] isFilling in
                self?.registrationButton.backgroundColor = isFilling ? .mainOrange : .lightOrange
            }
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        backgroundColor = .white
        registrationButton
            .addTarget(
                self,
                action: #selector(registrationButtonTapped),
                for: .touchUpInside
            )
        enterButton
            .addTarget(
                self,
                action: #selector(enterButtonTapped),
                for: .touchUpInside
            )
    }
    
    private func setupLayout() {
        addSubviewWithoutAutoresizingMask(topDecoration)
        addSubviewWithoutAutoresizingMask(nameTextField)
        addSubviewWithoutAutoresizingMask(lastnameTextField)
        addSubviewWithoutAutoresizingMask(emailTextField)
        addSubviewWithoutAutoresizingMask(passwordTextField)
        addSubviewWithoutAutoresizingMask(passwordConfirmationTextField)
        addSubviewWithoutAutoresizingMask(registrationButton)
        addSubviewWithoutAutoresizingMask(enterButton)
        addSubviewWithoutAutoresizingMask(agreementLabel)
        
        NSLayoutConstraint.activate([
            topDecoration.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topDecoration.topAnchor.constraint(equalTo: self.topAnchor),
            topDecoration.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            nameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            nameTextField.topAnchor.constraint(equalTo: topDecoration.bottomAnchor, constant: 32),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            lastnameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            lastnameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            lastnameTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            lastnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            
            emailTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: lastnameTextField.heightAnchor),
            emailTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 24),
            
            passwordTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            
            passwordConfirmationTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            passwordConfirmationTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            passwordConfirmationTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            
            agreementLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            agreementLabel.topAnchor.constraint(equalTo: passwordConfirmationTextField.bottomAnchor, constant: 74),
            
            registrationButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            registrationButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: 48),
            registrationButton.topAnchor.constraint(equalTo: agreementLabel.bottomAnchor, constant: 16),
            
            enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 48),
            enterButton.widthAnchor.constraint(equalToConstant: 92),
            enterButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 16)
        ])
    }
}

extension RegistrationView {
    
    @objc private func nameDidChange() {
        guard let name = nameTextField.text else { return }
        viewModel.name = name
    }
    @objc private func lastNameDidChange() {
        guard let lastName = lastnameTextField.text else { return }
        viewModel.lastName = lastName
    }
    @objc private func emailDidChange() {
        guard let email = emailTextField.text else { return }
        viewModel.email = email
    }
    @objc private func passwordDidChange() {
        guard let password = passwordTextField.text else { return }
        viewModel.password = password
    }
    @objc private func confirmPasswordDidChange() {
        guard let confirmPassword = passwordConfirmationTextField.text else { return }
        viewModel.confirmPassword = confirmPassword
    }

    @objc private func registrationButtonTapped() {
        print("test")
    }
    
    @objc private func enterButtonTapped() {
        delegate?.backToLogInScreen()
    }
}
