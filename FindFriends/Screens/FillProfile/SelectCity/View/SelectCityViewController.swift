import UIKit

final class SelectCityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        applyConstraints()
        setupSearchTF()
        setupButtonStack()
        view.backgroundColor = .systemBackground
        viewModel.filteredCitiesList = viewModel.citiesList
    }
    
    init(viewModel: CityViewModelProtocol = CityViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: CityViewModelProtocol
    
    private lazy var searchCityTextField: SearchFieldText = {
        let textField = SearchFieldText(placeholder: "Поиск")
        textField.addTarget(self, action: #selector(searchCities(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var searchButton = SearchButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectCityTableViewCell.self, forCellReuseIdentifier: SelectCityTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
    private lazy var acceptButton: PrimeOrangeButton = {
        let button = PrimeOrangeButton(text: "Выбрать")
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapAcceptButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: WhiteBorderButton = {
        let button = WhiteBorderButton(text: "Отменить")
        return button
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8.0
        return buttonStackView
    }()
    
    private func setupSearchTF() {
        searchCityTextField.leftView = searchButton
        searchCityTextField.leftViewMode = .always
    }
    
    private func setupButtonStack() {
        borderView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(acceptButton)
    }
    
    private func addView() {
        [searchCityTextField, tableView, acceptButton, cancelButton, borderView, buttonStackView ].forEach(view.addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            searchCityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchCityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchCityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.topAnchor.constraint(equalTo: searchCityTextField.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: borderView.topAnchor, constant: -2),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 100),
            buttonStackView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -24),
            buttonStackView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 24)
        ])
    }
    
    @objc func searchCities(_ textfield:UITextField) {
        if let searchText = textfield.text {
            viewModel.filteredCitiesList = searchText.isEmpty ? viewModel.citiesList :
            viewModel.citiesList.filter{$0.lowercased().contains(searchText.lowercased())}
            tableView.reloadData()
        }
    }
    
    @objc private func didTapAcceptButton() {
        let vc = SelectPhotoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.filteredCitiesList.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCityTableViewCell.identifier, for: indexPath) as? SelectCityTableViewCell else { return UITableViewCell() }
        let model = viewModel
        cell.configureCells(name: model.filteredCitiesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        acceptButton.backgroundColor = .mainOrange
        acceptButton.isEnabled = true
    }
}

extension SelectCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCityTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchCityTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchCityTextField.text != "" {
            return true
        } else {
            searchCityTextField.placeholder = "Поиск"
            return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
    }
}
