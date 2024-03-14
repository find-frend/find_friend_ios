import UIKit

open class TabBarController: UITabBarController  {

    fileprivate var shouldSelectOnTabBar = true
    
    private let customTabBar: TabBar
    
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

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(customTabBar, forKey: "tabBar")
        createTabBar()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    private var _barHeight: CGFloat = 74
    
    private func generateVC(_ viewController: UIViewController, _ title: String?, _ image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let vc = UINavigationController(rootViewController: viewController)
        vc.navigationBar.prefersLargeTitles = true
        return vc
    }
    
 
    //MARK: - CreateTabBar
    private func createTabBar() {
        
        viewControllers = [
            generateVC(TmpScreenViewController(), "Сообщения", UIImage(resource: .messagesWithoutNotification)),
            generateVC(SearchFriendsViewController(), "Поиск друзей", UIImage(resource: .searchFriends)),
            generateVC(TmpScreenViewController(), "Мероприятия", UIImage(resource: .events)),
            generateVC(TmpScreenViewController(), "Мой профиль", UIImage(resource: .myProfile))
        ]
    }

}
