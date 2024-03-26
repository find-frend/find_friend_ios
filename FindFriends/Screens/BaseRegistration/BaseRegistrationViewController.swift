//
//  BaseRegistrationViewController.swift
//  FindFriends
//
//  Created by Artem Novikov on 04.03.2024.
//

import UIKit

class BaseRegistrationViewController: UIViewController {

    private enum Constants {
        static let topDecorationInset: CGFloat = -0.3
        static let navBarContentHideMaxOffset: CGFloat = 100
    }

    private let baseRegistrationView: BaseRegistrationView
    private var notificationCenter: NotificationCenter {
        NotificationCenter.default
    }

    init(baseRegistrationView: BaseRegistrationView) {
        self.baseRegistrationView = baseRegistrationView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(cancelsTouchesInView: true)
        baseRegistrationView.scrollView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerKeyboardObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObserver()
    }

    private func registerKeyboardObserver() {
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObserver() {
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary,
              let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let keyboardSize = keyboardInfo.cgRectValue.size
        baseRegistrationView.scrollView.contentInset.bottom = keyboardSize.height
        baseRegistrationView.scrollView.verticalScrollIndicatorInsets.bottom = keyboardSize.height
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        baseRegistrationView.scrollView.contentInset.bottom = .zero
        baseRegistrationView.scrollView.verticalScrollIndicatorInsets.bottom = .zero
        baseRegistrationView.scrollView.setContentOffset(
            CGPoint(x: 0, y: Constants.topDecorationInset), 
            animated: true
        )
    }
}

// MARK: - UIScrollViewDelegate

extension BaseRegistrationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(
            scrollView.contentOffset.y >= Constants.navBarContentHideMaxOffset,
            animated: true
        )
    }
}
