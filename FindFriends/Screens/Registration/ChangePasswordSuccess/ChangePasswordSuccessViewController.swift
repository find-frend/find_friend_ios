//
//  ChangePasswordSuccessViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit


// MARK: - ChangePasswordSuccessViewController
final class ChangePasswordSuccessViewController: UIViewController {

    // MARK: - Private properties
    private let сhangePasswordSuccessView = ChangePasswordSuccessView()

    // MARK: - Overridden methods
    override func loadView() {
        view = сhangePasswordSuccessView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        сhangePasswordSuccessView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: false)
    }

}


// MARK: - ChangePasswordSuccessViewDelegate
extension ChangePasswordSuccessViewController: ChangePasswordSuccessViewDelegate {

    func didTapLogInButton() {
        navigationController?.popToRootViewController(animated: true)
    }

}
