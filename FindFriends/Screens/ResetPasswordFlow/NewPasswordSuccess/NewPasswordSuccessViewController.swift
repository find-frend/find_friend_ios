//
//  NewPasswordSuccessViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 21.02.2024.
//


import UIKit

final class NewPasswordSuccessViewController: UIViewController {
    private let newPasswordSuccessView = NewPasswordSuccessView()
    
    override func loadView() {
        view = newPasswordSuccessView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        newPasswordSuccessView.delegate = self
    }

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
