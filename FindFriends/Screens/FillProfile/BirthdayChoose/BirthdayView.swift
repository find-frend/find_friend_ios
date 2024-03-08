//
//  BirthdayView.swift
//  FindFriends
//
//  Created by Aleksey Kolesnikov on 28.02.2024.
//

import UIKit
import Combine

final class BirthdayView: UIView {
    
    weak var delegate: CustomUIPageControlProtocol?
    
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
        bind()
        setupViews()
        setupLayout()
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
        datePickTextField.hideWarningLabel()
        
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
            headerLabel.heightAnchor.constraint(equalToConstant: 41),
            headerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 36),
            
            datePickTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 52),
            datePickTextField.heightAnchor.constraint(equalToConstant: 44),
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
                    self?.nextButtonOn()
                } else {
                    self?.datePickTextField.showWarningForDate("недопустимое значение")
                    self?.nextButtonOff()
                }
            }
            .store(in: &cancellables)
        viewModel.$textFieldText
            .sink { [weak self] text in
                self?.datePickTextField.text = text
            }
            .store(in: &cancellables)
    }
    
    func nextButtonOff() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = .lightOrange
    }
    
    func nextButtonOn() {
        nextButton.isEnabled = true
        nextButton.backgroundColor = .mainOrange
    }
    
    @objc
    func nexButtonTap() {
        delegate?.sendPage(number: 2)
    }
}

extension BirthdayView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return false }
        let shouldChangeCharactersIn = viewModel.shouldChangeCharactersIn(text: text, range: range, replacementString: string)
        
        if viewModel.shouldHideKeyboard() {
            textField.text = NSString(string: text).replacingCharacters(in: range, with: string)
            textField.resignFirstResponder()
        }
        
        return shouldChangeCharactersIn
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        datePickTextField.hideWarningLabel()
        nextButtonOff()
        
        return true
    }
}
