//
//  WeatherViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 08.11.2022.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    
    var texts: [String]!
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        title = "Москва, Россия"
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        settingsItem.tintColor = .customBlack
        
        let locationItem = UIBarButtonItem(image: UIImage(systemName: "mappin.circle"), style: .plain, target: self, action: nil)
        locationItem.tintColor = .customBlack
        
        self.navigationItem.rightBarButtonItem = locationItem
        self.navigationItem.leftBarButtonItem = settingsItem
        texts = ["One", "Two", "Three"]
        
        self.dataSource = self
        self.delegate = self
        
        pageControl.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 50)
        self.view.addSubview(pageControl)
        
    }
    
    func x() {
        
    }
    
    lazy var createViewControllers: [WeatherViewController] = {
        var viewControllers = [WeatherViewController]()
        for text in ["One", "Two", "Three"] {
            viewControllers.append(WeatherViewController(text: text))
        }
        return viewControllers
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .customAccentBlueColor
        setViewControllers([self.createViewControllers[0]], direction: .forward, animated: true)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WeatherViewController else { return nil }
        if let index = createViewControllers.index(of: viewController) {
            if index > 0 {
                return createViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WeatherViewController else { return nil }
        if let index = createViewControllers.index(of: viewController) {
            if index < createViewControllers.count - 1 {
                return createViewControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return createViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
