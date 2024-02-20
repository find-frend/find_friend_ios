//
//  RegistrationTextField.swift
//  FindFriends
//
//  Created by Вадим Шишков on 11.02.2024.
//

import UIKit



final class RegistrationTextField: UITextField {
    
    enum TextFieldType {
        case personal
        case email
        case password
        case confirmPassword
    }
    
    var type: TextFieldType
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.captionRegular11
        label.textColor = Colors.warning
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.borderGray
        return view
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        button.imageView?.tintColor = Colors.primeDark
        button.setImage(UIImage(resource: .showPassword), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    init(placeholder text: String, type: TextFieldType) {
        self.type = type
        super.init(frame: .zero)
        
        setupViews(placeholder: text, type: type)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews(placeholder text: String, type: TextFieldType) {
        font = Fonts.body17
        textColor = Colors.primeDark
        
        if type == .password || type == .confirmPassword {
            isSecureTextEntry = true
            rightViewMode = .always
            rightView = showPasswordButton
            addTarget(self, action: #selector(showToggleButton), for: .editingChanged)
        }
        
        let text = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: Colors.placeholder,
                .font: Fonts.body17
        ])
        attributedPlaceholder = text
    }
    
    private func setupLayout() {
        addSubviewWithoutAutoresizingMask(separator)
        addSubviewWithoutAutoresizingMask(warningLabel)
        
        NSLayoutConstraint.activate([
            separator.widthAnchor.constraint(equalTo: widthAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            warningLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 2),
            warningLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    @objc private func showPassword() {
        isSecureTextEntry.toggle()
        showPasswordButton.setImage(
            isSecureTextEntry ? UIImage(resource: .showPassword) : UIImage(resource: .hidePassword),
            for: .normal
        )
    }
    
    @objc private func showToggleButton() {
        if let text = text {
            showPasswordButton.isHidden = text.isEmpty ? true : false
        }
    }
}

extension RegistrationTextField {
    func validateData(_ text: String) {
        switch type {
        case .personal:
            validatePersonal(text)
        case .email:
            validateEmail(text)
        case .password:
            validatePassword(text)
        case .confirmPassword:
            validateConfirmPassword(text)
        }
    }
    
    private func validatePersonal(_ text: String) {
        if text.count < 2 || text.count > 150 {
            warningLabel.text = "Имя должно содержать от 2 до 150 символов"
            warningLabel.isHidden = false
        }
    }
    
    private func validateEmail(_ email: String) {
        
    }
    
    private func validatePassword(_ password: String) {
        
    }
    
    private func validateConfirmPassword(_ password: String) {
        
    }
}
