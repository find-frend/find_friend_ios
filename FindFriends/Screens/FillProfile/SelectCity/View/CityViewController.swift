import UIKit

final class CityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addView()
        applyConstraints()
        setupSearchTF()
    }
    
    init(viewModel: CityViewModelProtocol = CityViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: CustomUIPageControlProtocol?

    private var viewModel: CityViewModelProtocol
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.text = "Выберите город"
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.text = "Чтобы видеть события и друзей"
        return label
    }()
    
    private lazy var searchCityTextField: SearchFieldText = {
        let textField = SearchFieldText(placeholder: "Поиск по названию")
        textField.delegate = self
        return textField
    }()
    
    private lazy var searchButton = SearchButton()
    
    private lazy var continueButton: PrimeOrangeButton = {
        let button = PrimeOrangeButton(text: "Далее")
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    private func setupSearchTF() {
        searchCityTextField.leftView = searchButton
        searchCityTextField.leftViewMode = .always
        tapGesture()
    }
    
    private func addView() {
        [firstLabel, secondLabel, searchCityTextField, continueButton, skipButton].forEach(view.addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 10),
            searchCityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchCityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchCityTextField.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 30),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSearchCityText))
        searchCityTextField.isUserInteractionEnabled = true
        searchCityTextField.addGestureRecognizer(tap)
    }
    
    @objc private func didTapContinueButton() {
        delegate?.sendPage(number: 4)
    }
    
    @objc private func didTapSkipButton() {
        delegate?.sendPage(number: 4)
        continueButton.backgroundColor = .lightOrange
        continueButton.isEnabled = false
    }
    
    @objc private func didTapSearchCityText() {
        let vc = SelectCityViewController()
        vc.delegate = self
        modalPresentationStyle = .currentContext
        present(vc, animated: true)
    }
}

extension CityViewController: ModalViewControllerDelegate {
    func modalControllerWillDisapear(_ model: SelectCityViewController, withDismiss result: Bool) {
        if result {
            continueButton.backgroundColor = .mainOrange
            continueButton.isEnabled = true
        } else {
            continueButton.backgroundColor = .lightOrange
            continueButton.isEnabled = false
        }
    }
}

extension CityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCityTextField.endEditing(false)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchCityTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchCityTextField.text != "" {
            return true
        } else {
            searchCityTextField.placeholder = "Поиск по названию"
            return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
    }
}

