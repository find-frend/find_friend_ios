//
//  BirthdayView.swift
//  FindFriends
//
//  Created by Aleksey Kolesnikov on 28.02.2024.
//

import UIKit
import Combine

protocol BirthdayViewDelegate {
    func changeTextFieldText(text: String)
    func changeButtonAndErrorLabel(dateIsCorrect: Bool)
}

final class BirthdayView: UIView {
    let viewModel = BirthdayViewModel()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите дату рождения"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .primeDark
        
        return label
    }()
    private let datePickTextField = RegistrationTextField(
        placeholder: "ДД.ММ.ГГГГ",
        type: .date
    )
    
    private let nextButton = PrimeOrangeButton(text: "Продолжить")
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
}

private extension BirthdayView {
    func setupViews() {
        backgroundColor = .white
        
        datePickTextField.keyboardType = .numberPad
        datePickTextField.delegate = self
        datePickTextField.clearButtonMode = .whileEditing
        
        nextButton.isEnabled = false
        nextButton.addTarget(self, action: #selector(nexButtonTap), for: .touchUpInside)
    }
    
    func setupLayout() {
        addSubviewWithoutAutoresizingMask(headerLabel)
        addSubviewWithoutAutoresizingMask(datePickTextField)
        addSubviewWithoutAutoresizingMask(nextButton)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 36),
            
            datePickTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 52),
            datePickTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            datePickTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            nextButton.leadingAnchor.constraint(equalTo: datePickTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: datePickTextField.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -102),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    func bind() {
        viewModel.$buttonAndError
            .sink { [weak self] dateIsCorrect in
                if dateIsCorrect {
                    self?.datePickTextField.hideWarningLabel()
                } else {
                    self?.datePickTextField.showWarningForDate("недопустимое значение")
                }
                
                self?.nextButton.isEnabled = dateIsCorrect
                if dateIsCorrect {
                    self?.nextButton.backgroundColor = .mainOrange
                } else {
                    self?.nextButton.backgroundColor = .lightOrange
                }
            }
            .store(in: &cancellables)
        viewModel.$textFieldText
            .sink { [weak self] text in
                self?.datePickTextField.text = text
            }
            .store(in: &cancellables)
    }
    
    @objc
    func nexButtonTap() {
        print("next 2")
    }
}

extension BirthdayView: BirthdayViewDelegate {
    func changeTextFieldText(text: String) {
        datePickTextField.text = text
    }
    
    func changeButtonAndErrorLabel(dateIsCorrect: Bool) {
        if dateIsCorrect {
            datePickTextField.hideWarningLabel()
        } else {
            datePickTextField.showWarningForDate("недопустимое значение")
        }
        
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
