//
//  RegistrationView.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import Combine
import SafariServices
import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func presentWebPage(_ page: SFSafariViewController)
    func showAlert(_ model: AlertModel)
}

final class RegistrationView: UIView {
    let viewModel = RegistrationViewModel(registrationService: RegistrationService())
    weak var delegate: RegistrationViewDelegate?
    
    lazy var nameTextField: RegistrationTextField = {
        let textField = RegistrationTextField( placeholder: "Имя", type: .name)
        textField.addTarget(self, action: #selector(nameDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var lastnameTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Фамилия", type: .lastName)
        textField.addTarget(self, action: #selector(lastNameDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Электронная почта", type: .email)
        textField.addTarget(self, action: #selector(emailDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Пароль", type: .password)
        textField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        return textField
    }()  
    
    lazy var passwordConfirmationTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholder: "Повторите пароль", type: .confirmPassword)
        textField.addTarget(self, action: #selector(confirmPasswordDidChange), for: .editingChanged)
        return textField
    }()
    
    
    let registrationButton = PrimeOrangeButton(text: "Зарегистрироваться")
    
    lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(agreementDidTapped)))
        
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
            .sink { [weak self] isFilling in
                self?.registrationButton.setEnabled(isFilling)
            }
            .store(in: &cancellables)
        
        viewModel.$errorTextForName
            .sink { [unowned self] error in
                if error.isEmpty {
                    nameTextField.hideWarningLabel()
                } else {
                    nameTextField.showWarningLabel(error)
                }
            }
            .store(in: &cancellables) 
        
        viewModel.$errorTextForLastName
            .sink { [unowned self] error in
                if error.isEmpty {
                    lastnameTextField.hideWarningLabel()
                } else {
                    lastnameTextField.showWarningLabel(error)
                }
            }
            .store(in: &cancellables) 
        
        viewModel.$errorTextForEmail
            .sink { [unowned self] error in
                if error.isEmpty {
                    emailTextField.hideWarningLabel()
                } else {
                    emailTextField.showWarningLabel(error)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorTextForPassword
            .sink { [unowned self] error in
                if error.isEmpty {
                    passwordTextField.hideWarningLabel()
                } else {
                    passwordTextField.showWarningLabel(error)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorTextForConfirmPassword
            .sink { [unowned self] error in
                if error.isEmpty {
                    passwordConfirmationTextField.hideWarningLabel()
                } else {
                    passwordConfirmationTextField.showWarningLabel(error)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$webPage
            .sink { [weak self] page in
                guard let page else { return }
                self?.delegate?.presentWebPage(page)
            }
            .store(in: &cancellables)
        
        viewModel.$alert
            .sink { [unowned self] model in
                guard let model else { return }
                delegate?.showAlert(model)
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
    }
    
    private func setupLayout() {
        addSubviewWithoutAutoresizingMask(topDecoration)
        addSubviewWithoutAutoresizingMask(nameTextField)
        addSubviewWithoutAutoresizingMask(lastnameTextField)
        addSubviewWithoutAutoresizingMask(emailTextField)
        addSubviewWithoutAutoresizingMask(passwordTextField)
        addSubviewWithoutAutoresizingMask(passwordConfirmationTextField)
        addSubviewWithoutAutoresizingMask(registrationButton)
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
            registrationButton.topAnchor.constraint(equalTo: agreementLabel.bottomAnchor, constant: 16)
        ])
    }
}

extension RegistrationView {
    
    @objc private func nameDidChange() {
        guard let name = nameTextField.text else { return }
        viewModel.name = name
        if name.isEmpty {
            nameTextField.hideWarningLabel()
        }
    }
    @objc private func lastNameDidChange() {
        guard let lastName = lastnameTextField.text else { return }
        viewModel.lastName = lastName
        if lastName.isEmpty {
            lastnameTextField.hideWarningLabel()
        }
    }
    @objc private func emailDidChange() {
        guard let email = emailTextField.text else { return }
        viewModel.email = email
        if email.isEmpty {
            emailTextField.hideWarningLabel()
        }
    }
    @objc private func passwordDidChange() {
        guard let password = passwordTextField.text else { return }
        viewModel.password = password
        if password.isEmpty {
            passwordTextField.hideWarningLabel()
        }
    }
    @objc private func confirmPasswordDidChange() {
        guard let confirmPassword = passwordConfirmationTextField.text else { return }
        viewModel.confirmPassword = confirmPassword
        if confirmPassword.isEmpty {
            passwordConfirmationTextField.hideWarningLabel()
        }
    }

    @objc private func registrationButtonTapped() {
        viewModel.registrationButtonTapped()
    }
    
    @objc private func agreementDidTapped() {
        viewModel.agreementDidTapped()
    }
}
