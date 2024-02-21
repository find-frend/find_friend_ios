//
//  RegistrationView.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import UIKit

protocol RegistrationViewProtocol {
    var viewModel: RegistrationViewModelProtocol { get }
    var delegate: RegistrationViewDelegate? { get set }
    var nameTextField: RegistrationTextField { get }
    var lastnameTextField: RegistrationTextField { get }
    var emailTextField: RegistrationTextField { get }
    var passwordTextField: RegistrationTextField { get }
    var passwordConfirmationTextField: RegistrationTextField { get }
    var registrationButton: PrimeOrangeButton { get }
    var enterButton: CaptionButton { get }
    var agreementLabel: UILabel { get }
}

protocol RegistrationViewDelegate: AnyObject {
    func backToSignInScreen()
}

final class RegistrationView: UIView, RegistrationViewProtocol {
    let viewModel: RegistrationViewModelProtocol = RegistrationViewModel()
    weak var delegate: RegistrationViewDelegate?
    
    let nameTextField: RegistrationTextField = {
        let textField = RegistrationTextField( placeholder: "Имя", type: .personal)
        return textField
    }()
    
    let lastnameTextField = RegistrationTextField(
        placeholder: "Фамилия", type: .personal
    )
    let emailTextField = RegistrationTextField(
        placeholder: "Электронная почта", type: .email
    )
    let passwordTextField = RegistrationTextField(
        placeholder: "Пароль", type: .password
    )
    let passwordConfirmationTextField = RegistrationTextField(
        placeholder: "Повторите пароль", type: .confirmPassword
    )
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
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

    @objc private func registrationButtonTapped() {

    }
    
    @objc private func enterButtonTapped() {
        
    }
}
