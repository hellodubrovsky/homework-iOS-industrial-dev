//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Илья on 08.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    weak var coordinator: MainCoordinator?
    private var someViewControllers = [UINavigationController]()
    
    init(coordinator: MainCoordinator, viewControllers: [UINavigationController]) {
        self.coordinator = coordinator
        self.someViewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
        self.delegate = self
    }
    
    private func setTabBarController() {
        self.viewControllers = self.someViewControllers
        self.selectedViewController = self.someViewControllers.first
        self.tabBar.tintColor = UIColor.init(named: "colorBaseVK")
        self.tabBar.unselectedItemTintColor = .black
        let backgroundColor = UIColor(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: CGFloat(1.0))
        self.tabBar.backgroundColor = backgroundColor
        self.tabBar.isTranslucent = false
    }
}


extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard viewController is ImagePickerViewController else { return true }
        let imagePicker = ImagePickerViewController()
        tabBarController.present(imagePicker, animated: true, completion: nil)
        return false
    }
}
