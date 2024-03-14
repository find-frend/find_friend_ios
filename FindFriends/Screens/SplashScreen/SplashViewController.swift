//
//  SplashViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import UIKit

// MARK: - SplashViewController
final class SplashViewController: UIViewController {

    // MARK: - Private properties
    private let oauthTokenStorage = OAuthTokenStorage.shared
    private let splashView = SplashView()

    // MARK: - Overridden methods
    override func loadView() {
        view = splashView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        uncomment for testing
        oauthTokenStorage.token = nil
        if let _ = oauthTokenStorage.token {
            presentTabBarController()
        } else {
            presentLoginViewController()
        }
    }

    // MARK: - Private methods
    private func presentLoginViewController() {
        let navigationController = RegistrationNavigationController()
        let viewController = LoginViewController()
        viewController.delegate = self
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false)
    }

    private func presentTabBarController() {
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = scene.windows.first
        else { fatalError("Invalid Configuration") }
        let tabBar = TabBar()
        let tabBarController = TabBarController(customTabBar: tabBar)
        window.rootViewController = tabBarController
    }

}

// MARK: - LoginViewControllerDelegate
extension SplashViewController: LoginViewControllerDelegate {
    func didAuthenticate() {
        presentTabBarController()
    }
}
