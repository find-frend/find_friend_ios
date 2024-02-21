//
//  NewPasswordView.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit


// - MARK: NewPasswordViewDelegate
protocol NewPasswordViewDelegate: AnyObject {
    func didTapSavePasswordButton()
}


// - MARK: NewPasswordView
final class NewPasswordView: BaseRegistrationView {

    // MARK: - Public properties
    weak var delegate: NewPasswordViewDelegate?

    // MARK: - Private properties
    private enum Constants {
        enum Label {
            static let topInset: CGFloat = 32
        }
        enum TextField {
            static let height: CGFloat = 48
            static let topInset: CGFloat = 16
            static let bottomInset: CGFloat = 24
        }
        enum Button {
            static let height: CGFloat = 48
            static let bottomInset: CGFloat = 85
        }
    }

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.numberOfLines = 0
        label.font = .Regular.medium
        label.text = "Придумайте новый пароль. Он должен отличаться от вашего старого пароля."
        return label
    }()
    private let passwordTextField = RegistrationTextField(
        placeholder: "Пароль", type: .password
    )
    private let passwordConfirmationTextField = RegistrationTextField(
        placeholder: "Повторите пароль", type: .password
    )
    private let savePasswordButton = PrimeOrangeButton(text: "Сохранить пароль")

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupViews() {
        scrollView.addSubviewWithoutAutoresizingMask(label)
        scrollView.addSubviewWithoutAutoresizingMask(passwordTextField)
        scrollView.addSubviewWithoutAutoresizingMask(passwordConfirmationTextField)
        scrollView.addSubviewWithoutAutoresizingMask(savePasswordButton)

        savePasswordButton.addTarget(
            self,
            action: #selector(savePasswordButtonTapped),
            for: .touchUpInside
        )
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            label.topAnchor.constraint(
                equalTo: topDecoration.bottomAnchor,
                constant: Constants.Label.topInset
            ),

            passwordTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            passwordTextField.topAnchor.constraint(
                equalTo: label.bottomAnchor,
                constant: Constants.TextField.topInset
            ),

            passwordConfirmationTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            passwordConfirmationTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            passwordConfirmationTextField.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: Constants.TextField.bottomInset
            ),

            savePasswordButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            savePasswordButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            savePasswordButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            scrollView.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: savePasswordButton.bottomAnchor,
                constant: Constants.Button.bottomInset
            )
        ])
    }

    @objc private func savePasswordButtonTapped() {
        delegate?.didTapSavePasswordButton()
    }

}
