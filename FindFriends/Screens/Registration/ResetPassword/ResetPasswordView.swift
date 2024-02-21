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
}


// - MARK: ResetPasswordView
final class ResetPasswordView: BaseRegistrationView {
    
    // MARK: - Public properties
    weak var delegate: ResetPasswordViewDelegate?

    // MARK: - Private properties
    private enum Constants {
        enum TextView {
            static let topInset: CGFloat = 32
        }
        enum TextField {
            static let height: CGFloat = 48
            static let topInset: CGFloat = 12
        }
        enum Button {
            static let bottomInset: CGFloat = 21
        }
    }

    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.font = .Regular.medium
        textView.textColor = .primeDark
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        textView.text = "Укажите электронную почту, связанную с вашей учетной записью. " +
                        "Мы отправим вам письмо с инструкциями по сбросу пароля."
        return textView
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupViews() {
        scrollView.addSubviewWithoutAutoresizingMask(textView)
        scrollView.addSubviewWithoutAutoresizingMask(emailTextField)
        scrollView.addSubviewWithoutAutoresizingMask(emailTextField)
        scrollView.addSubviewWithoutAutoresizingMask(sendInstructionButton)

        sendInstructionButton.addTarget(
            self,
            action: #selector(sendInstructionButtonTapped),
            for: .touchUpInside
        )
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            textView.topAnchor.constraint(
                equalTo: topDecoration.bottomAnchor,
                constant: Constants.TextView.topInset
            ),

            emailTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            emailTextField.topAnchor.constraint(
                equalTo: textView.bottomAnchor,
                constant: Constants.TextField.topInset
            ),

            sendInstructionButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            sendInstructionButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            sendInstructionButton.heightAnchor.constraint(equalToConstant: Constants.TextField.height),
            scrollView.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: sendInstructionButton.bottomAnchor,
                constant: Constants.Button.bottomInset
            )
        ])
    }

    @objc private func sendInstructionButtonTapped() {
        delegate?.didTapSendInstructionButton()
    }

}
