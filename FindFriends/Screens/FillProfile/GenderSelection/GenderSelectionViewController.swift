//
//  GenderSelectionViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class GenderSelectionViewController: UIViewController {
    
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
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 52
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var genderManImageView: UIImageView = {
        let image: UIImage = .genderMan
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var genderManButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(genderManTapped), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 17, trailing: 0)
        configuration.baseBackgroundColor = .white
        button.configuration = configuration
        button.setTitle("Мужской", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.textGray, for: .normal)
        button.contentVerticalAlignment = .bottom
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var genderWomanImageView: UIImageView = {
        let image: UIImage = .genderWoman
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var genderWomanButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(genderWomanTapped), for: .touchUpInside)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 17, trailing: 0)
        configuration.baseBackgroundColor = .white
        button.configuration = configuration
        button.setTitle("Женский", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.textGray, for: .normal)
        button.contentVerticalAlignment = .bottom
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        button.backgroundColor = .lightOrange
        button.isEnabled = false
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButtonActive: Bool = false

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
        if nextButtonActive {
            delegate?.sendPage(number: currentPage == 4 ? 0 : currentPage + 1)
        }
    }
    
    @objc
    private func genderManTapped() {
        genderManSelected(isTrue: true)
    }
    
    @objc
    private func genderWomanTapped() {
        genderManSelected(isTrue: false)
    }
    
    private func genderManSelected(isTrue: Bool) {
        if isTrue {
            genderManButton.configuration?.baseBackgroundColor = .buttonGray
            genderManButton.setTitleColor(.primeDark, for: .normal)
            genderWomanButton.configuration?.baseBackgroundColor = .white
            genderWomanButton.setTitleColor(.textGray, for: .normal)
        } else {
            genderManButton.configuration?.baseBackgroundColor = .white
            genderManButton.setTitleColor(.textGray, for: .normal)
            genderWomanButton.configuration?.baseBackgroundColor = .buttonGray
            genderWomanButton.setTitleColor(.primeDark, for: .normal)
        }
        nextButtonActive = true
        actionButton.backgroundColor = .mainOrange
        actionButton.isEnabled = true
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

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainInfoText.bottomAnchor, constant: 74),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 122)
        ])
        stackView.addArrangedSubview(genderWomanButton)
        genderWomanButton.addSubview(genderWomanImageView)
        NSLayoutConstraint.activate([
            genderWomanButton.widthAnchor.constraint(equalToConstant: 97),
            genderWomanImageView.centerXAnchor.constraint(equalTo: genderWomanButton.centerXAnchor),
            genderWomanImageView.topAnchor.constraint(equalTo: genderWomanButton.topAnchor, constant: 5)
        ])
        stackView.addArrangedSubview(genderManButton)
        genderManButton.addSubview(genderManImageView)
        NSLayoutConstraint.activate([
            genderManButton.widthAnchor.constraint(equalToConstant: 97),
            genderManImageView.centerXAnchor.constraint(equalTo: genderManButton.centerXAnchor),
            genderManImageView.topAnchor.constraint(equalTo: genderManButton.topAnchor, constant: 5)
        ])
    }
}

