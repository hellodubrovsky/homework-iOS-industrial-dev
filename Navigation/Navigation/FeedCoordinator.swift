//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Илья on 08.06.2022.
//

import Foundation
import UIKit

protocol FeedCoordinator {
    func openPostViewController()
    func openInfoViewController()
    func openImageUserViewController()
}


final class FeedCoordinatorImplementation: FeedCoordinator {
    
    var navigationController: UINavigationController
    weak var presenter: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init(presenter: UIViewController, navigationController: UINavigationController) {
        self.init(navigationController: navigationController)
        self.presenter = presenter
    }
    
    func openPostViewController() {
        print("TAP -> Открывается окно post")
        let postViewController = PostViewController()
        let titlePost: Post = Post(title: "Post")
        postViewController.title = titlePost.title
        self.navigationController.pushViewController(postViewController, animated: true)
    }
    
    func openInfoViewController() {
        print("TAP -> Открывается окно info")
        let infoViewController = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        presenter?.present(infoNavigationController, animated: true)
    }
    
    func openImageUserViewController() {
        let imagesUsserViewController = ImagesUserViewController()
        self.navigationController.pushViewController(imagesUsserViewController, animated: true)
    }
}
