//
//  ImagesUserTabBarController.swift
//  Navigation
//
//  Created by Илья on 03.08.2022.
//

import UIKit

class ImagesUserTabBarController: UITabBarController {
    
    // MARK: Private properties
    weak var coordinator: UserImagesCoordinator!
    private var someViewControllers: [UINavigationController]
    
    
    
    // MARK: Initial
    
    init(coordinator: UserImagesCoordinator, viewControllers: [UINavigationController]) {
        self.coordinator = coordinator
        self.someViewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
    }
    
    
    
    // MARK: Private methods

    private func setTabBarController() {
        self.viewControllers = someViewControllers
        self.selectedViewController = someViewControllers.first
        self.tabBar.tintColor = UIColor.init(named: "colorBaseVK")
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.backgroundColor = UIColor(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: CGFloat(1.0))
        self.tabBar.isTranslucent = false
    }
}
