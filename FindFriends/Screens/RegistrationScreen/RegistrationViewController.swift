//
//  RegistrationViewController.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private var registrationView: RegistrationViewProtocol

    override func loadView() {
        self.view = registrationView as? UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        registrationView.delegate = self
    }
    
    init(registrationView: RegistrationViewProtocol) {
        self.registrationView = registrationView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Регистрация"
       
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func backToSignInScreen() {
        navigationController?.popViewController(animated: true)
    }
}
