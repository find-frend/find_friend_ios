//
//  WelcomeViewController.swift
//  FindFriends
//
//  Created by Victoria Isaeva on 21.03.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    var viewModel: WelcomeViewModel?
    private let stackView = UIStackView()
    
    private let welcomeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeLabel")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primeDark
        label.text = "Привет, Анастасия!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundLaunchScreen
        setupUI()
        viewModel = WelcomeViewModel()
        
        viewModel?.fetchUserData { success in
            if success {
                DispatchQueue.main.async {
                    self.configureUI()
                }
            } else {
                print("Ошибка при загрузке данных")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateWelcomeViewEntrance()
        animateWelcomeLabelEntrance()
    }
    
    private func setupUI() {
        stackView.axis = .vertical
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 216),
            welcomeView.widthAnchor.constraint(equalToConstant: 137),
            welcomeView.heightAnchor.constraint(equalToConstant: 139),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        stackView.addArrangedSubview(welcomeView)
        welcomeLabel.textAlignment = .center
        stackView.addArrangedSubview(welcomeLabel)
        stackView.setCustomSpacing(20, after: welcomeView)
    }
    
    private func configureUI() {
        guard let viewModel = viewModel else {
            print("viewModel is nil.")
            return
        }
        welcomeLabel.text = "Привет, \(viewModel.welcomeModel.firstName)!"
    }
    
    private func animateWelcomeViewEntrance() {
        welcomeView.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        UIView.animate(withDuration: 0.8, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.welcomeView.transform = .identity
        }, completion: nil)
    }
    
    private func animateWelcomeLabelEntrance() {
        welcomeLabel.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        UIView.animate(withDuration: 0.8, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.welcomeLabel.transform = .identity
        }, completion: nil)
    }
}
