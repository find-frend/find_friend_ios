//
//  RegistrationNavigationController.swift
//  FindFriends
//
//  Created by Artem Novikov on 20.02.2024.
//

import UIKit


// MARK: - RegistrationNavigationController
final class RegistrationNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.prefersLargeTitles = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .primeDark
        navigationBar.backIndicatorImage = .back
        navigationBar.backIndicatorTransitionMaskImage = .back
    }

}


// MARK: - UIGestureRecognizerDelegate
extension RegistrationNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

}
