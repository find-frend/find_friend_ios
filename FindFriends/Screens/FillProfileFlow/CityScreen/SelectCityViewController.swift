import UIKit

protocol ModalViewControllerDelegate: AnyObject {
    func modalControllerWillDisapear(_ model: SelectCityViewController, withDismiss param: Bool)
    func updateSearchTextField(name: String, withDismiss param: Bool)
}

final class SelectCityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addView()
        applyConstraints()
        setupButtonStack()
        viewModel.filteredCitiesList = viewModel.citiesList
    }
    
    init(viewModel: CityViewModelProtocol = CityViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ModalViewControllerDelegate?
    
    private var viewModel: CityViewModelProtocol

    private lazy var searchCityTextField: UISearchBar = {
        let textField = UISearchBar()
        textField.placeholder = "Поиск"
        textField.searchBarStyle = UISearchBar.Style.minimal
        textField.searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [
            .foregroundColor: UIColor.searchBar,
            .font: UIFont.Regular.medium
        ])
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.searchTextField.textColor = .black
        textField.searchTextField.addTarget(self, action: #selector(searchCities(_:)), for: .editingChanged)
        textField.backgroundColor = .searchTextFieldBackground
        for subview in textField.searchTextField.subviews {
            subview.backgroundColor = .clear
            subview.alpha = 0
        }
        return textField
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small11
        label.textColor = .warning
        label.text = "Не найдено"
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
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
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
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
    
    private func setupButtonStack() {
        borderView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(acceptButton)
    }
    
    private func addView() {
        [searchCityTextField, warningLabel, separator, tableView, acceptButton, cancelButton, borderView, buttonStackView ].forEach(view.addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            searchCityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchCityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchCityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchCityTextField.heightAnchor.constraint(equalToConstant: 38),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            warningLabel.topAnchor.constraint(equalTo: searchCityTextField.bottomAnchor, constant: 4),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 4),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: borderView.topAnchor, constant: -2),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 140),
            buttonStackView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -60),
            buttonStackView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 24)
        ])
    }
    
    @objc func searchCities(_ textfield: UITextField) {
        if let searchText = textfield.text {
            viewModel.filteredCitiesList = searchText.isEmpty ? viewModel.citiesList :
            viewModel.citiesList.filter{$0.lowercased().contains(searchText.lowercased())}
            tableView.reloadData()
            if viewModel.filteredCitiesList.isEmpty {
                warningLabel.isHidden = false
                searchCityTextField.layer.borderColor = UIColor.red.cgColor
                searchCityTextField.layer.borderWidth = 1
                searchCityTextField.searchTextField.textColor = .red
            } else {
                warningLabel.isHidden = true
                searchCityTextField.layer.borderColor = UIColor.clear.cgColor
                searchCityTextField.layer.borderWidth = 0
                searchCityTextField.searchTextField.textColor = .black
            }
        }
    }
    
    @objc private func didTapAcceptButton() {
        delegate?.modalControllerWillDisapear(self, withDismiss: true)
        delegate?.updateSearchTextField(name: viewModel.selectCity, withDismiss: true)
        dismiss(animated: true)
    }
    
    @objc private func didTapCancelButton() {
        delegate?.modalControllerWillDisapear(self, withDismiss: false)
        delegate?.updateSearchTextField(name: "Поиск по названию", withDismiss: false)
        dismiss(animated: true)
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
        guard let cell = tableView.cellForRow(at: indexPath) as? SelectCityTableViewCell else {
            return
        }
        viewModel.selectCity = cell.label.text ?? ""
        acceptButton.backgroundColor = .mainOrange
        acceptButton.isEnabled = true
    }
}
