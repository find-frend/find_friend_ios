//
//  ResetPasswordView.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit


// - MARK: ResetPasswordViewDelegate
protocol ResetPasswordViewDelegate: AnyObject {
    func didTapSendInstructionButton()
    func didChangeTextField()
}


// - MARK: ResetPasswordView
final class ResetPasswordView: BaseRegistrationView {

    // MARK: - Public properties
    weak var delegate: ResetPasswordViewDelegate?
    var email: String {
        emailTextField.text ?? ""
    }

    // MARK: - Private properties
    private enum Constants {
        enum Label {
            static let topInset: CGFloat = 32
        }
        enum TextField {
            static let height: CGFloat = 48
            static let topInset: CGFloat = 12
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
        label.text = "Укажите электронную почту, связанную с вашей учетной записью. " +
                     "Мы отправим вам письмо с инструкциями по сбросу пароля."
        return label
    }()
    private let emailTextField = RegistrationTextField(
        placeholder: "Электронная почта", type: .email
    )
    private let sendInstructionButton = PrimeOrangeButton(text: "Отправить инструкцию")

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        emailTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func setSendInstructionButton(enabled: Bool) {
        sendInstructionButton.setEnabled(enabled)
    }

    func setEmailTextFieldError(message: String) {
        if message.isEmpty {
            emailTextField.hideWarningLabel()
        } else {
            emailTextField.showWarningLabel(message)
        }
    }

    // MARK: - Private methods
    private func setupViews() {
        contentView.addSubviewWithoutAutoresizingMask(label)
        contentView.addSubviewWithoutAutoresizingMask(emailTextField)
        contentView.addSubviewWithoutAutoresizingMask(sendInstructionButton)

        sendInstructionButton.addTarget(
            self,
            action: #selector(sendInstructionButtonTapped),
            for: .touchUpInside
        )
        emailTextField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged
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

            emailTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            emailTextField.topAnchor.constraint(
                equalTo: label.bottomAnchor,
                constant: Constants.TextField.topInset
            ),

            sendInstructionButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            sendInstructionButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            sendInstructionButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: sendInstructionButton.bottomAnchor,
                constant: Constants.Button.bottomInset
            )
        ])
    }

    @objc private func sendInstructionButtonTapped() {
        delegate?.didTapSendInstructionButton()
    }

    @objc private func textFieldChanged() {
        delegate?.didChangeTextField()
    }

}


// - MARK: UITextFieldDelegate
extension ResetPasswordView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }

}
