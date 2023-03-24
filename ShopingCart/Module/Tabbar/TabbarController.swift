
import UIKit
import Lottie

class MainTabBarController: UITabBarController {
    // MARK: UIComponent
    private lazy var animationView : LottieAnimationView = {
        let animationView = LottieAnimationView(name: "cart", animationCache: .none)
        animationView.contentMode = .scaleToFill
        animationView.animationSpeed = 0.3
        animationView.loopMode = .loop
        animationView.layer.masksToBounds = true
        animationView.layer.cornerRadius = 30
        animationView.frame = CGRect(x: ScreenSize.widht/2 - 30, y: ScreenSize.height + 100, width: 60, height: 60)
        animationView.translatesAutoresizingMaskIntoConstraints = true
        return animationView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
        animationLottie()
    }
    fileprivate func animationLottie() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToCart))
        self.animationView.addGestureRecognizer(gestureRecognizer)
        view.addSubview(animationView)
        UIView.animate(withDuration: 0.9, animations: { [self] in
            self.animationView.frame = CGRect(x: Int(ScreenSize.widht)/2 - 30,
                                              y:tabBarSize.tabbarPozisiton(tabbarMiny: tabBar.frame.minY),
                                              width: 60,
                                              height: 60)
            
        })
        animationView.play()
    }
    
    func setupTabBar() {
        let viewControllers = [homeViewController(), productViewController(), cartViewController(), profileViewController()]
        setViewControllers(viewControllers, animated: true)
    }
    @objc func goToCart() {
        
    }
    
    private func configureTabBar() {
        tabBar.itemPositioning = .fill
        tabBar.barTintColor = .systemGray5
        tabBar.tintColor = .mainAppColor
    }
    
    private func homeViewController() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        return UINavigationController(rootViewController: homeVC)
    }
    
    private func productViewController() -> UINavigationController {
        let productListVC = ProductListViewController()
        productListVC.tabBarItem = UITabBarItem(title: "Product List",
                                                image: UIImage(systemName: "list.bullet"),
                                                selectedImage: UIImage(systemName: "list.bullet"))
        return UINavigationController(rootViewController: productListVC)
    }
    
    private func cartViewController() -> UINavigationController {
        let cartVC = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Cart",
                                         image: UIImage(systemName: "cart.fill"),
                                         selectedImage: UIImage(systemName: "cart.fill" ))
        return UINavigationController(rootViewController: cartVC)
    }
    
    private func profileViewController() -> UINavigationController {
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person" ),
                                            selectedImage: UIImage(systemName: "person.fill"))
        return UINavigationController(rootViewController: profileVC)
    }
}
