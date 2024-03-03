//
//  NextViewControler.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class NextViewController: UIViewController {
    
    weak var delegate: CustomUIPageControlProtocol?
    
    private var viewControllerNumber: Int?

    private var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "primeDark")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var mainInfoText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "primeDark")
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(didTapActionButton(sender: ))
        )
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "mainOrange")
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(
        label: String,
        infoText: String,
        viewControllerNumber: Int?
    ) {
        self.mainLabel.text = label
        self.mainInfoText.text = infoText
        self.viewControllerNumber = viewControllerNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraints()
    }

    // MARK: - Objective-C functions
    @objc
    func didTapActionButton(sender: UIButton) {
        guard let currentPage = viewControllerNumber else {
            assertionFailure("Error main label")
            return
        }
        delegate?.sendPage(number: currentPage == 4 ? 0 : currentPage + 1)
    }
    
    private func configureConstraints() {

        view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 41)
        ])

        view.addSubview(mainInfoText)
        NSLayoutConstraint.activate([
            mainInfoText.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            mainInfoText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainInfoText.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -84),
            actionButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

