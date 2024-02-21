//
//  ChangePasswordSuccessView.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//

import UIKit


// - MARK: ChangePasswordSuccessViewDelegate
protocol ChangePasswordSuccessViewDelegate: AnyObject {
    func didTapLogInButton()
}


// - MARK: ChangePasswordSuccessView
final class ChangePasswordSuccessView: BaseRegistrationView {

    // MARK: - Public properties
    weak var delegate: ChangePasswordSuccessViewDelegate?

    // MARK: - Private properties
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
            static let bottomInset: CGFloat = 89
        }
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .success
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.font = .Bold.large
        label.text = "Пароль сохранён"
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.numberOfLines = 0
        label.font = .Regular.medium
        label.text = "Поздравляем. Теперь вы можете войти в свой профиль, используя новый пароль."
        label.textAlignment = .center
        return label
    }()

    private let logInButton = PrimeOrangeButton(text: "Войти")

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
        scrollView.addSubviewWithoutAutoresizingMask(imageView)
        scrollView.addSubviewWithoutAutoresizingMask(titleLabel)
        scrollView.addSubviewWithoutAutoresizingMask(subtitleLabel)
        scrollView.addSubviewWithoutAutoresizingMask(logInButton)

        logInButton.addTarget(
            self,
            action: #selector(logInButtonTapped),
            for: .touchUpInside
        )
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.centerYAnchor.constraint(
                equalTo: imageView.centerYAnchor,
                constant: Constants.ImageView.widthAndHeight / 2
            ),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            imageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),

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

            logInButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            scrollView.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: logInButton.bottomAnchor,
                constant: Constants.Button.bottomInset
            )
        ])
    }

    @objc private func logInButtonTapped() {
        delegate?.didTapLogInButton()
    }

}

