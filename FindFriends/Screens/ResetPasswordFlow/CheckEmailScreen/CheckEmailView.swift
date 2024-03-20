//
//  CheckEmailView.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit

protocol CheckEmailViewDelegate: AnyObject {
    func didTapBackToLogInButton()
    func didTapBackToResetPasswordButton()
}

final class CheckEmailView: BaseRegistrationView {
    weak var delegate: CheckEmailViewDelegate?

    private enum Constants {
        enum ImageView {
            static let topInset: CGFloat = 74
            static let widthAndHeight: CGFloat = 120
        }
        enum Label {
            enum Title {
                static let topInset: CGFloat = 32
            }
            enum Subtitle {
                static let topInset: CGFloat = 16
            }
        }
        enum Button {
            static let height: CGFloat = 48
        }
        enum Caption {
            static let topInset: CGFloat = 25
            static let bottomInset: CGFloat = 21
            static let text = """
                            Не получили письмо? Проверьте папку Спам
                            или Введите другой почтовый адрес
                            """
            static let tappablePart = "Введите другой почтовый адрес"
        }
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .email
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.font = .Bold.large
        label.text = "Проверьте почту"
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.numberOfLines = 0
        label.font = .Regular.medium
        label.text = """
                Мы отправили инструкцию по сбросу пароля на вашу электронную почту.
                Пройдите по ссылке из письма, чтобы установить новый пароль для входа.
                """
        label.textAlignment = .center
        return label
    }()

    private let backToLogInButton = PrimeOrangeButton(text: "Вернуться ко входу")

    private lazy var caption: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: Constants.Caption.text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.alignment = .center
        attributedText.addAttributes(
            [
                .font: UIFont.Regular.small13,
                .foregroundColor: UIColor.primeDark,
                .paragraphStyle: style
            ],
            range: NSRange(location: 0, length: attributedText.length)
        )
        attributedText.addAttributes(
            [
                .font: UIFont.Bold.small,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.mainOrange,
            ],
            range: rangeOfTappablePartOfCaption
        )
        label.attributedText = attributedText
        label.isUserInteractionEnabled = true
        return label
    }()

    private var rangeOfTappablePartOfCaption: NSRange {
        return (Constants.Caption.text as NSString).range(of: Constants.Caption.tappablePart)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubviewWithoutAutoresizingMask(imageView)
        contentView.addSubviewWithoutAutoresizingMask(titleLabel)
        contentView.addSubviewWithoutAutoresizingMask(subtitleLabel)
        contentView.addSubviewWithoutAutoresizingMask(backToLogInButton)
        contentView.addSubviewWithoutAutoresizingMask(caption)

        backToLogInButton.addTarget(
            self,
            action: #selector(backToLogInButtonTapped),
            for: .touchUpInside
        )
        caption.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(backToResetPasswordButtonTapped(gesture:))
            )
        )
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            imageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            contentView.centerYAnchor.constraint(
                equalTo: imageView.centerYAnchor,
                constant: Constants.ImageView.widthAndHeight / 2
            ),

            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Constants.Label.Title.topInset
            ),

            subtitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.Label.Subtitle.topInset
            ),

            backToLogInButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            backToLogInButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            backToLogInButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            caption.topAnchor.constraint(
                equalTo: backToLogInButton.bottomAnchor,
                constant: Constants.Caption.topInset
            ),

            caption.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            caption.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: caption.bottomAnchor,
                constant: Constants.Caption.bottomInset
            )
        ])
    }

    @objc private func backToLogInButtonTapped() {
        delegate?.didTapBackToLogInButton()
    }

    @objc private func backToResetPasswordButtonTapped(gesture: UITapGestureRecognizer) {
        guard gesture.didTapAttributedTextInLabel(label: caption, inRange: rangeOfTappablePartOfCaption)
        else { return }
        delegate?.didTapBackToResetPasswordButton()
    }
}
