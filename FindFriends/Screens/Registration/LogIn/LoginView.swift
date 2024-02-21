//
//  LoginView.swift
//  FindFriends
//
//  Created by Artem Novikov on 20.02.2024.
//


import UIKit


// - MARK: LoginViewDelegate
protocol LoginViewDelegate: AnyObject {
    func didTapRegistrationButton()
    func didTapLoginButton()
    func didTapForgotPasswordButton()
}


// - MARK: LoginView
final class LoginView: BaseRegistrationView {

    // MARK: - Public Properties
    weak var delegate: LoginViewDelegate?

    // MARK: - Private Properties
    private enum Constants {
        enum Circle {
            enum Big {
                static let width: CGFloat = 184
                static let trailingInset: CGFloat = 48
                static let topInset: CGFloat = 33
            }
            enum Small {
                static let width: CGFloat = 133
                static let leadingInset: CGFloat = 33
                static let bottomInset: CGFloat = 33
            }
        }
        enum TextField {
            static let height: CGFloat = 48
            enum Email {
                static let inset: CGFloat = 36
            }
            enum Password {
                static let topInset: CGFloat = 24
            }
        }
        enum Button {
            enum Forgot {
                static let height: CGFloat = 44
                static let topInset: CGFloat = 4
            }
            enum LogIn {
                static let bottomInset: CGFloat = 16
            }
            enum Registration {
                static let bottomInset: CGFloat = 21
            }
        }
    }

    private let bigCircleView: UIView = CircleView(
        cornerRadius: Constants.Circle.Big.width / 2
    )
    private let smallCircleView: UIView = CircleView(
        cornerRadius: Constants.Circle.Small.width / 2
    )
    private let emailTextField = RegistrationTextField(
        placeholder: "Электронная почта", type: .email
    )
    private let passwordTextField = RegistrationTextField(
        placeholder: "Пароль", type: .password
    )
    private let logInButton = PrimeOrangeButton(text: "Войти")
    private let registrationButton = CaptionButton(text: "Регистрация")
    private let forgotPasswordButton = UnderlinedButton(text: "Забыли пароль?")

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupViews() {
        contentView.addSubviewWithoutAutoresizingMask(bigCircleView)
        contentView.addSubviewWithoutAutoresizingMask(smallCircleView)
        contentView.addSubviewWithoutAutoresizingMask(emailTextField)
        contentView.addSubviewWithoutAutoresizingMask(passwordTextField)
        contentView.addSubviewWithoutAutoresizingMask(logInButton)
        contentView.addSubviewWithoutAutoresizingMask(registrationButton)
        contentView.addSubviewWithoutAutoresizingMask(forgotPasswordButton)

        logInButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        registrationButton.addTarget(
            self,
            action: #selector(registrationButtonTapped),
            for: .touchUpInside
        )
        forgotPasswordButton.addTarget(
            self,
            action: #selector(forgotPasswordButtonTapped),
            for: .touchUpInside
        )
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            bigCircleView.widthAnchor.constraint(equalToConstant: Constants.Circle.Big.width),
            bigCircleView.heightAnchor.constraint(equalToConstant: Constants.Circle.Big.width),
            topDecoration.bottomAnchor.constraint(
                equalTo: bigCircleView.topAnchor,
                constant: Constants.Circle.Big.topInset
            ),
            bigCircleView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.Circle.Big.trailingInset
            ),

            emailTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            contentView.centerYAnchor.constraint(
                equalTo: emailTextField.centerYAnchor,
                constant: Constants.TextField.Email.inset
            ),

            passwordTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            passwordTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: Constants.TextField.Password.topInset
            ),

            forgotPasswordButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            forgotPasswordButton.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: Constants.Button.Forgot.topInset
            ),
            forgotPasswordButton.heightAnchor.constraint(
                equalToConstant: Constants.Button.Forgot.height
            ),

            smallCircleView.widthAnchor.constraint(equalToConstant: Constants.Circle.Small.width),
            smallCircleView.heightAnchor.constraint(equalToConstant: Constants.Circle.Small.width),
            logInButton.topAnchor.constraint(
                equalTo: smallCircleView.bottomAnchor,
                constant: Constants.Circle.Small.bottomInset
            ),
            leadingAnchor.constraint(
                equalTo: smallCircleView.leadingAnchor,
                constant: Constants.Circle.Small.leadingInset
            ),

            logInButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            registrationButton.topAnchor.constraint(
                equalTo: logInButton.bottomAnchor,
                constant: Constants.Button.LogIn.bottomInset
            ),

            registrationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: registrationButton.bottomAnchor,
                constant: Constants.Button.Registration.bottomInset
            )
        ])
    }

    @objc private func loginButtonTapped() {
        delegate?.didTapLoginButton()
    }

    @objc private func registrationButtonTapped() {
        delegate?.didTapRegistrationButton()
    }

    @objc private func forgotPasswordButtonTapped() {
        delegate?.didTapForgotPasswordButton()
    }

}


// - MARK: UITextFieldDelegate
extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            endEditing(true)
        }
        return false
    }

}


// - MARK: CircleView
fileprivate class CircleView: UIView {

    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        backgroundColor = .mainOrange.withAlphaComponent(0.2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// - MARK: UnderlinedButton
fileprivate class UnderlinedButton: UIButton {

    init(text: String) {
        super.init(frame: .zero)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.Semibold.small,
            .foregroundColor: UIColor.primeDark,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: text,
            attributes: attributes
        )
        titleLabel?.font = .Regular.small12
        setAttributedTitle(attributeString, for: .normal)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
