//
//  NewPasswordViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit

final class NewPasswordViewController: BaseRegistrationViewController {

    private let newPasswordView: NewPasswordView

    init(
        newPasswordView: NewPasswordView
    ) {
        self.newPasswordView = newPasswordView
        super.init(baseRegistrationView: newPasswordView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = newPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        newPasswordView.delegate = self
    }

    private func configureNavigationBar() {
        navigationItem.title = "Новый пароль"
    }
}

// MARK: - NewPasswordViewDelegate

extension NewPasswordViewController: NewPasswordViewDelegate {
    func showSuccessScreen() {
        let controller = NewPasswordSuccessViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
