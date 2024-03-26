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
        
        //        раскоментировать, чтобы при каждом входе сбрасывался вход
        //        oauthTokenStorage.token = nil
        if let _ = oauthTokenStorage.token {
            presentWelcomeViewController()
        } else {
            presentLoginViewController()
        }
    }
    
    private func presentWelcomeViewController() {
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = scene.windows.first
        else { fatalError("Invalid Configuration") }
        
        let welcomeViewController = WelcomeViewController()
        window.rootViewController = welcomeViewController
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.presentTabBarController()
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
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        }, completion: nil)
    }
}
