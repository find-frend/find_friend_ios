//
//  BaseRegistrationView.swift
//  FindFriends
//
//  Created by Artem Novikov on 20.02.2024.
//

import UIKit


// MARK: - BaseRegistrationView
class BaseRegistrationView: UIView {

    // MARK: - Public properties
    let topDecoration: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .topDecoration
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    // MARK: - Private properties
    private enum Constants {
        static let topDecorationInset: CGFloat = -0.3
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .white
        scrollView.scrollsToTop = false
        return scrollView
    }()

    private var notificationCenter: NotificationCenter {
        NotificationCenter.default
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupViews()
        setupLayout()
        registerKeyboardObserver()
        scrollView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeKeyboardObserver()
    }

    // MARK: - Private methods
    private func setupViews() {
        addSubviewWithoutAutoresizingMask(scrollView)
        scrollView.addSubviewWithoutAutoresizingMask(contentView)
        contentView.addSubviewWithoutAutoresizingMask(topDecoration)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            topDecoration.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topDecoration.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topDecoration.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.topDecorationInset
            ),
        ])
    }

    private func registerKeyboardObserver() {
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(notification:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }

    private func removeKeyboardObserver() {
        notificationCenter.removeObserver(self,
                                          name: UIResponder.keyboardWillShowNotification,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: UIResponder.keyboardWillHideNotification,
                                          object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary,
              let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let keyboardSize = keyboardInfo.cgRectValue.size
        scrollView.contentInset.bottom = keyboardSize.height
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardSize.height
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets.bottom = .zero
        scrollView.setContentOffset(CGPoint(x: 0, y: Constants.topDecorationInset), animated: true)
    }

}


// MARK: - UIScrollViewDelegate
extension BaseRegistrationView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.parentViewController?
            .navigationController?
            .setNavigationBarHidden(scrollView.contentOffset.y >= 100, animated: true)
    }

}
