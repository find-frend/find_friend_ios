//
//  PageViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class GenderSelectionViewController: UIViewController {

    private lazy var image = UIImage()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageView.image = image
        return imageView
    }()

    private var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var mainInfoText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var actionButtonShow: Bool = false

    init(label: String, infoText: String, buttonShow: Bool, image: UIImage) {
        self.mainLabel.text = label
        self.mainInfoText.text = infoText
        self.actionButtonShow = buttonShow

        super.init(nibName: nil, bundle: nil)
        self.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        configureConstraints()
    }

    private lazy var actionButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(didTapActionButton(sender: ))
        )
        button.setTitle(NSLocalizedString("onboarding.thirdPageVC.actionButton", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
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
        print("Action button tapped")
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

    private func addGradient() {
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [

            blackColor(with: 1.0),
            blackColor(with: 0.0)
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = gradientView.bounds
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
    }

    private func blackColor(with alpha: CGFloat) -> CGColor {
        return UIColor.black.withAlphaComponent(alpha).cgColor
    }

    private func addActionButton() {

        
    }

    private func configureConstraints() {

        addGradient()

        view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.addSubview(mainInfoText)
        NSLayoutConstraint.activate([
            mainInfoText.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 12),
            mainInfoText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainInfoText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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

