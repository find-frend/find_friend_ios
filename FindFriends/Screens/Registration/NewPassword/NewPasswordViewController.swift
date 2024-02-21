//
//  NewPasswordViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit


// MARK: - NewPasswordViewController
final class NewPasswordViewController: UIViewController {

    // MARK: - Private properties
    private let newPasswordView = NewPasswordView()

    // MARK: - Overridden methods
    override func loadView() {
        view = newPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        hideKeyboardWhenTappedAround()
        newPasswordView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.title = "Новый пароль"
    }

}


// MARK: - NewPasswordViewDelegate
extension NewPasswordViewController: NewPasswordViewDelegate {

    func didTapSavePasswordButton() {
        let viewController = NewPasswordSuccessViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}
