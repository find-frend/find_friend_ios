//
//  CustomUIPageViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit
final class CustomUIPageViewController: UIPageViewController {

    private lazy var firstPageVC = GenderSelectionViewController(
        label: "Ваш пол",
        infoText: "Влияет на события, \n которые Вам будут доступны",
        buttonShow: false,
        image: UIImage(),
        viewControllerNumber: 0
    )

    private lazy var secondPageVC = GenderSelectionViewController(
        label: "Введите дату рождения",
        infoText: "",
        buttonShow: false,
        image: UIImage(),
        viewControllerNumber: 1
    )

    private lazy var thirdPageVC = GenderSelectionViewController(
        label: "Интересы",
        infoText: "Выберите свои увлечения, чтобы найти \n единомышленников",
        buttonShow: true,
        image: UIImage(),
        viewControllerNumber: 2
    )
    
    private lazy var fourthPageVC = GenderSelectionViewController(
        label: "Выберите город",
        infoText: "Чтобы видеть события и друзей",
        buttonShow: true,
        image: UIImage(),
        viewControllerNumber: 3
    )
    
    private lazy var fifthPageVC = GenderSelectionViewController(
        label: "Фото профиля",
        infoText: "Добавьте фото, чтобы другим было проще Вас узнать",
        buttonShow: true,
        image: UIImage(),
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
        [firstPageVC, secondPageVC, thirdPageVC, fourthPageVC, fifthPageVC].forEach { $0.delegate = self }
        removeSwipeGesture()
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
}

// MARK: - CustomPageControlProtocol
extension CustomUIPageViewController: CustomUIPageControlProtocol {
    func send(currentPage: Int) {
        customPageControl.currentPage = currentPage
        let viewController = pages[currentPage]
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - GenderSelectionViewControllerProtocol
extension CustomUIPageViewController: GenderSelectionViewControllerProtocol
{
    func send(nextPage: Int) {
        customPageControl.currentPage = nextPage
        let viewController = pages[nextPage]
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
        view.addSubview(customPageControl)
        NSLayoutConstraint.activate([
            customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            customPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            customPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            customPageControl.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

