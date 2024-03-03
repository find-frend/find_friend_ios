//
//  GenderSelectionViewConteroller.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class CustomUIPageViewController: UIPageViewController {

    private let firstPageVC = GenderSelectionViewController(
        label: NSLocalizedString("onboarding.firstPageVC.mainLabel", comment: ""),
        infoText: NSLocalizedString("onboarding.firstPageVC.mainInfoText", comment: ""),
        buttonShow: false,
        image: UIImage(named: "email")!
    )

    private let secondPageVC = GenderSelectionViewController(
        label: NSLocalizedString("onboarding.secondPageVC.mainLabel", comment: ""),
        infoText: NSLocalizedString("onboarding.secondPageVC.mainInfoText", comment: ""),
        buttonShow: false,
        image: UIImage(named: "success")!
    )

    private let thirdPageVC = GenderSelectionViewController(
        label: NSLocalizedString("onboarding.thirdPageVC.mainLabel", comment: ""),
        infoText: NSLocalizedString("onboarding.thirdPageVC.mainInfoText", comment: ""),
        buttonShow: true,
        image: UIImage(named: "back")!
    )

    private lazy var pages: [UIViewController] = {
        return [firstPageVC, secondPageVC, thirdPageVC]
    }()

    private lazy var customPageControl: CustomUIPageControl = {
        let control = CustomPageControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .clear
        control.pageIndicatorTintColor = .clear
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
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
        dataSource = self
        delegate = self
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        configConstraints()
        customPageControl.delegate = self
        overrideUserInterfaceStyle = .dark
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - CustomPageControlProtocol
extension OnboardingViewController: CustomPageControlProtocol {
    func send(currentPage: Int) {
        customPageControl.currentPage = currentPage
        let viewController = pages[currentPage]
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
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
extension OnboardingViewController: UIPageViewControllerDelegate {
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
private extension OnboardingViewController {
    func configConstraints() {
        view.addSubview(customPageControl)
        NSLayoutConstraint.activate([
            customPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customPageControl.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}

