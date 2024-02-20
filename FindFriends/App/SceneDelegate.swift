//
//  SceneDelegate.swift
//  FindFriends
//
//  Created by Vitaly on 08.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let navigationController = RegistrationNavigationController()
        let viewController = LoginViewController()
        navigationController.viewControllers = [viewController]
        #warning("Изменить root vc во время разработки своего экрана")
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

