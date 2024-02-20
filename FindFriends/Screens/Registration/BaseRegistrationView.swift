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

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupViews() {
        addSubviewWithoutAutoresizingMask(scrollView)
        scrollView.addSubviewWithoutAutoresizingMask(topDecoration)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            topDecoration.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topDecoration.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topDecoration.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }

}
