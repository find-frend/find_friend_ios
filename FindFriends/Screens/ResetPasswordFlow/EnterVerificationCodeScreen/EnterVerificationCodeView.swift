//
//  EnterVerificationCodeView.swift
//  FindFriends
//
//  Created by Вадим Шишков on 22.03.2024.
//
import Combine
import UIKit

final class EnterVerificationCodeView: BaseRegistrationView {
    let viewModel: EnterVerificationCodeViewModel
    
    private let confirmButton = PrimeOrangeButton(text: "Подтвердить")
    private let sendCodeAgainButton = CaptionButton(text: "Отправить код еще раз")
    private var fields: [UITextField] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.font = .Bold.large
        label.text = "Введите код"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var caption: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.numberOfLines = 0
        label.font = .Regular.medium
        label.textAlignment = .center
        label.text = "Мы отправили код на вашу почту\n\(viewModel.email)"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        for _ in 1...6 {
            let textField = UITextField()
            textField.backgroundColor = UIColor(resource: .searchTextFieldBackground)
            textField.layer.cornerRadius = 10
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
            textField.delegate = self
            stackView.addArrangedSubview(textField)
            fields.append(textField)
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()

    init(viewModel: EnterVerificationCodeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupViews()
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for:  .touchUpInside)
        sendCodeAgainButton.addTarget(self, action: #selector(sendCodeAgainButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        contentView.addSubviewWithoutAutoresizingMask(header)
        contentView.addSubviewWithoutAutoresizingMask(caption)
        contentView.addSubviewWithoutAutoresizingMask(sendCodeAgainButton)
        contentView.addSubviewWithoutAutoresizingMask(confirmButton)
        contentView.addSubviewWithoutAutoresizingMask(stackView)
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: sendCodeAgainButton.topAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48),
            
            sendCodeAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendCodeAgainButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            header.centerXAnchor.constraint(equalTo: centerXAnchor),
            header.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: topDecoration.bottomAnchor, constant: 104),
            
            caption.centerXAnchor.constraint(equalTo: centerXAnchor),
            caption.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            caption.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            caption.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: caption.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func bind() {
        viewModel.$isFullfill
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isFullfill in
                confirmButton.setEnabled(isFullfill)
            }
            .store(in: &cancellables)
    }
    
    @objc private func confirmButtonTapped() {
        viewModel.confirmButtonTapped()
    }
    
    @objc private func sendCodeAgainButtonTapped() {
        viewModel.sendCodeAgainButtonTapped()
    }
}

// MARK: - UITextField

extension EnterVerificationCodeView: UITextFieldDelegate {
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        if let index = fields.firstIndex(of: textField) {
            if index < fields.count - 1 {
                let textField = fields[index + 1]
                textField.becomeFirstResponder()
            } else {
                fields[index].resignFirstResponder()
            }
            viewModel.fields[index].send(textField.text!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
              !currentText.isEmpty else { return true }
        return string.isEmpty
    }
}
