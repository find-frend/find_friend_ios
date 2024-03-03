//
//  GenderSelectionViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

protocol GenderSelectionViewControllerProtocol: AnyObject {
    func send(nextPage: Int)
}

import UIKit
final class GenderSelectionViewController: UIViewController {
    
    weak var delegate: GenderSelectionViewControllerProtocol?

    private lazy var image = UIImage()
    
    private var viewControllerNumber: Int?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageView.image = image
        return imageView
    }()

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

    private var showActionButton: Bool = false

    init(
        label: String,
        infoText: String,
        buttonShow: Bool,
        image: UIImage,
        viewControllerNumber: Int?
    ) {
        self.mainLabel.text = label
        self.mainInfoText.text = infoText
        self.showActionButton = buttonShow
        self.viewControllerNumber = viewControllerNumber

        super.init(nibName: nil, bundle: nil)
        self.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        configureConstraints()
    }

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.actionButton.accessibilityIdentifier = "ActionButton"
    }

    // MARK: - Objective-C functions
    @objc
    func didTapActionButton(sender: UIButton) {
        guard let currentPage = viewControllerNumber else {
            assertionFailure("Error main label")
            return
        }
        delegate?.send(nextPage: currentPage == 4 ? 0 : currentPage + 1)
    }

    private func setNextViewControllerAsRoot() {
        var keyWindow: UIWindow?
        let allScenes = UIApplication.shared.connectedScenes
          for scene in allScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows where window.isKeyWindow {
                keyWindow = window
             }
           }
        guard let keyWindow = keyWindow else {
            assertionFailure("Error to find keyWindow")
            return
        }
        let nextViewController = RegistrationViewController(registrationView: RegistrationView())
        keyWindow.rootViewController = nextViewController
    }

    private func blackColor(with alpha: CGFloat) -> CGColor {
        return UIColor.black.withAlphaComponent(alpha).cgColor
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

