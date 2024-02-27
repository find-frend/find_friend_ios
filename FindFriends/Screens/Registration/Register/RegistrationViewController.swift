//
//  RegistrationViewController.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//
import SafariServices
import UIKit

final class RegistrationViewController: UIViewController {
    private var registrationView: RegistrationView

    override func loadView() {
        self.view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        registrationView.delegate = self
    }
    
    init(registrationView: RegistrationView) {
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
    func presentWebPage(_ page: SFSafariViewController) {
        present(page, animated: true)
    }
    
    func showAlert(_ model: AlertModel) {
        AlertPresenter.show(in: self, model: model)
    }
    
    func goToGenderScreen() {
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = scene.windows.first
        else { fatalError("Invalid Configuration") }
        // let genderScreen = GenderScreen()
        // window.rootViewController = genderScreen
    }
}
