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

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .white
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // MARK: - Private properties
    private enum Constants {
        static let topDecorationInset: CGFloat = -0.3
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupViews() {
        backgroundColor = .white
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
            )
        ])
    }

}
