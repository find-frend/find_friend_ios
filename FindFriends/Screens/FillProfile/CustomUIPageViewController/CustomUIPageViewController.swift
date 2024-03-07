//
//  CustomUIPageViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class CustomUIPageViewController: UIPageViewController {

    private lazy var firstPageVC = GenderSelectionViewController(genderView: GenderView())

    private lazy var secondPageVC = BirthdayViewController(birthdayView: BirthdayView())

    private lazy var thirdPageVC = SelectInterestsViewController()
    
    private lazy var fourthPageVC = NextViewController(
        label: "Выберите город",
        infoText: "Чтобы видеть события и друзей",
        viewControllerNumber: 3
    )
    
    private lazy var fifthPageVC = NextViewController(
        label: "Фото профиля",
        infoText: "Добавьте фото, чтобы другим было проще Вас узнать",
        viewControllerNumber: 4
    )

    private lazy var pages: [UIViewController] = {
        return [firstPageVC, secondPageVC, thirdPageVC, fourthPageVC, fifthPageVC]
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
    
    override func loadView() {
        super.loadView()
        dataSource = self
        delegate = self
        customPageControl.delegate = self
        firstPageVC.genderView.delegate = self
        secondPageVC.birthdayView.delegate = self
        thirdPageVC.selectInterestsView.delegate = self
        [fourthPageVC, fifthPageVC].forEach { $0.delegate = self }
        removeSwipeGesture()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configConstraints()
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        moveToNextViewControllerWith(number: customPageControl.currentPage - 1)
    }
}

// MARK: - CustomPageControlProtocol
extension CustomUIPageViewController: CustomUIPageControlProtocol {
    func currentPage(number: Int) {
        backButton.isHidden = number == 0 ? true : false
    }
    
    func sendPage(number: Int) {
        moveToNextViewControllerWith(number: number)
    }
    
    private func moveToNextViewControllerWith(number: Int) {
        customPageControl.currentPage = number
        let viewController = pages[number]
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension CustomUIPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return pages.last
        }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return pages.first
        }
        return pages[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension CustomUIPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
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
        NSLayoutConstraint.activate([
            customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            customPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            customPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            customPageControl.heightAnchor.constraint(equalToConstant: 36)
        ])
        view.addSubviewWithoutAutoresizingMask(backButton)
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: customPageControl.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: customPageControl.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
