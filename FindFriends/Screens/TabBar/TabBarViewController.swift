import UIKit

class TabBarViewController: UITabBarController {
    
    fileprivate var shouldSelectOnTabBar = true
    
    let customTabBar: TabBar
    
    init(customTabBar: TabBar) {
        self.customTabBar = customTabBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? TabBar, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? TabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
     }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(customTabBar, forKey: "tabBar")
        generateTabBar()
    }
    
    open var barHeight: CGFloat {
        get {
                return _barHeight + view.safeAreaInsets.bottom
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }
    
    private var _barHeight: CGFloat = 74

    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

    open override func viewSafeAreaInsetsDidChange() {
            super.viewSafeAreaInsetsDidChange()
        updateTabBarFrame()
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: CatalogViewController(), title: "Сообщения", image: UIImage(systemName: "bell")),
            generateVC(viewController: CatalogViewController(), title: "Поиск друзей", image: UIImage(systemName: "magnifyingglass")),
            generateVC(viewController: CatalogViewController(), title: "Мероприятия", image: UIImage(systemName: "calendar")),
            generateVC(viewController: CatalogViewController(), title: "Мой профиль", image: UIImage(systemName: "person"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }
}
