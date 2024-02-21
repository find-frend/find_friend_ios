//
//  NewPasswordSuccessViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit


// MARK: - NewPasswordSuccessViewController
final class NewPasswordSuccessViewController: UIViewController {

    // MARK: - Private properties
    private let newPasswordSuccessView = NewPasswordSuccessView()

    // MARK: - Overridden methods
    override func loadView() {
        view = newPasswordSuccessView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        newPasswordSuccessView.delegate = self
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: false)
    }

}


// MARK: - NewPasswordSuccessViewDelegate
extension NewPasswordSuccessViewController: NewPasswordSuccessViewDelegate {

    func didTapLogInButton() {
        navigationController?.popToRootViewController(animated: true)
    }

}
