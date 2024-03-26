//
//  CustomUIPageViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class CustomUIPageViewController: UIPageViewController {

    private lazy var firstPageVC = GenderViewController(genderView: GenderView())
    private lazy var secondPageVC = BirthdayViewController(birthdayView: BirthdayView())
    private lazy var thirdPageVC = SelectInterestsViewController()
    private lazy var fourthPageVC = CityViewController()
    private lazy var fifthPageVC = PhotoViewController()

    private lazy var pages: [UIViewController] = {
        [firstPageVC, secondPageVC, thirdPageVC, fourthPageVC, fifthPageVC]
    }()

    private lazy var customPageControl: CustomUIPageControl = {
        let control = CustomUIPageControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .clear
        control.pageIndicatorTintColor = .clear
        return control
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.isHidden = true
        button.setImage(.back, for: .normal)
        return button
    }()

    override init(
        transitionStyle: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        removeSwipeGesture()
        configConstraints()
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
        customPageControl.delegate = self
        firstPageVC.genderView.delegate = self
        secondPageVC.birthdayView.delegate = self
        thirdPageVC.selectInterestsView.delegate = self
        fourthPageVC.delegate = self
        fifthPageVC.delegate = self
    }
    
    private func removeSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    @objc
    private func backButtonTapped() {
        moveToViewControllerWith(index: customPageControl.currentPage - 1, direction: .reverse)
    }
}

// MARK: - CustomPageControlProtocol

extension CustomUIPageViewController: CustomUIPageControlProtocol {
    func currentPage(number: Int) {
        backButton.isHidden = number == 0 ? true : false
    }
    
    func sendPage(number: Int) {
        moveToViewControllerWith(index: number, direction: .forward)
    }
    
    private func moveToViewControllerWith(index: Int, direction: NavigationDirection) {
        customPageControl.currentPage = index
        let viewController = pages[index]
        setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource

extension CustomUIPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController),
            currentIndex > 0
        else { return nil }
        return pages[currentIndex - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController)
    -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController),
              currentIndex < pages.count
        else { return nil }
        return pages[currentIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate

extension CustomUIPageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            customPageControl.currentPage = currentIndex
        }
    }
}

// MARK: - Configure constraints

private extension CustomUIPageViewController {
    func configConstraints() {
        view.addSubviewWithoutAutoresizingMask(customPageControl)
        view.addSubviewWithoutAutoresizingMask(backButton)
        NSLayoutConstraint.activate([
            customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            customPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            customPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            customPageControl.heightAnchor.constraint(equalToConstant: 36),
            backButton.centerYAnchor.constraint(equalTo: customPageControl.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: customPageControl.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
