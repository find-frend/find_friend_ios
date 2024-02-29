//
//  BirthdayView.swift
//  FindFriends
//
//  Created by Aleksey Kolesnikov on 28.02.2024.
//

import UIKit

protocol BirthdayViewDelegate {
    func changeTextFieldText(text: String)
    func changeButtonAndErrorLabel(dateIsCorrect: Bool)
}

final class BirthdayView: UIView {
    let viewModel = BirthdayViewModel()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите дату рождения"
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .center
        label.textColor = .primeDark
        
        return label
    }()
    private lazy var datePickTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ДД.ММ.ГГГГ"
        textField.font = .Regular.medium
        textField.textColor = .primeDark
        textField.keyboardType = .numberPad
        textField.borderStyle = UITextField.BorderStyle.none
        textField.delegate = self
        textField.backgroundColor = .clear
        
        return textField
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "недопустимое значение"
        label.font = UIFont.Regular.small11
        label.textAlignment = .left
        label.textColor = .warning
        label.isHidden = true
        
        return label
    }()
    
    private let nextButton = PrimeOrangeButton(text: "Продолжить")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func underLineTextField() {
        datePickTextField.underlined(color: UIColor.textFieldBorder)
    }
}

private extension BirthdayView {
    func setupViews() {
        addTapGestureToHideKeyboard()
        backgroundColor = .white
        
        nextButton.isEnabled = false
        nextButton.addTarget(self, action: #selector(nexButtonTap), for: .touchUpInside)
    }
    
    func setupLayout() {
        addSubviewWithoutAutoresizingMask(headerLabel)
        addSubviewWithoutAutoresizingMask(datePickTextField)
        addSubviewWithoutAutoresizingMask(errorLabel)
        addSubviewWithoutAutoresizingMask(nextButton)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            datePickTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 52),
            datePickTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            datePickTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            datePickTextField.heightAnchor.constraint(equalToConstant: 44),
            
            errorLabel.topAnchor.constraint(equalTo: datePickTextField.bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: datePickTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: datePickTextField.trailingAnchor),
            errorLabel.heightAnchor.constraint(equalToConstant: 13),
            
            nextButton.leadingAnchor.constraint(equalTo: datePickTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: datePickTextField.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -102),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func tapGesture() {
        self.resignFirstResponder()
    }
    
    @objc
    func nexButtonTap() {
        //TODO: - Add next action
    }
}

extension BirthdayView: BirthdayViewDelegate {
    func changeTextFieldText(text: String) {
        datePickTextField.text = text
    }
    
    func changeButtonAndErrorLabel(dateIsCorrect: Bool) {
        errorLabel.isHidden = dateIsCorrect
        nextButton.isEnabled = dateIsCorrect
        
        if dateIsCorrect {
            nextButton.backgroundColor = .mainOrange
            return
        }
        nextButton.backgroundColor = .lightOrange
    }
}

extension BirthdayView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return viewModel.shouldChangeCharactersIn(text: textField.text, range: range, replacementString: string)
    }
}
