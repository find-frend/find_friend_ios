//
//  CustomUIPageView.swift
//  FindFriends
//
//  Created by Ognerub on 3/5/24.
//

import UIKit
import Combine

final class CustomUIPageView: UIView {
    
    // MARK: Properties
    let viewModel = CustomUIPageViewModel()
    
    private lazy var firstPageVC = GenderSelectionViewController(genderView: GenderView())

    private lazy var secondPageVC = BirthdayViewController(birthdayView: BirthdayView())

    private lazy var thirdPageVC = NextViewController(
        label: "Интересы",
        infoText: "Выберите свои увлечения, чтобы найти \n единомышленников",
        viewControllerNumber: 2
    )
    
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
        let control = CustomUIPageControl(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .clear
        control.pageIndicatorTintColor = .clear
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private var cancelLables: Set<AnyCancellable> = []
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomUIPageView {
    // MARK: Bind
    func bind() {

    }
    
    // MARK: Setup Views
    func setupViews() {
        
        if let first = pages.first {
            print("first")
            //setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        
        customPageControl.delegate = self
        [thirdPageVC, fourthPageVC, fifthPageVC].forEach { $0.delegate = self }
        
        if let first = pages.first {
            print("first")
            //setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        
        
        backgroundColor = .black
    }
    
    // MARK: Setup Layout
    func setupLayout() {
        addSubviewWithoutAutoresizingMask(customPageControl)
        NSLayoutConstraint.activate([
            customPageControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            customPageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
            customPageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
            customPageControl.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

// MARK: - CustomPageControlProtocol
extension CustomUIPageView: CustomUIPageControlProtocol {
    func sendPage(number: Int) {
        customPageControl.currentPage = number
        let viewController = pages[number]
        print("delegate")
        //setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension CustomUIPageView: UIPageViewControllerDataSource {
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
extension CustomUIPageView: UIPageViewControllerDelegate {
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


