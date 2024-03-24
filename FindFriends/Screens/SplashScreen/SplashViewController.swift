//
//  SplashViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {

    private let oauthTokenStorage = OAuthTokenStorage.shared
    private let splashView = SplashView()

    override func loadView() {
        self.view = splashView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        раскоментировать, чтобы при каждом входе сбрасывался token
//        oauthTokenStorage.token = nil
        if let _ = oauthTokenStorage.token {
            presentTabBarController()
        } else {
            presentLoginViewController()
        }
    }

    private func presentLoginViewController() {
        let navigationController = RegistrationNavigationController()
        let viewController = LoginViewController()
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
