//
//  PostViewController.swift
//  Navigation
//
//  Created by Илья on 28.11.2021.
//

import UIKit

final class PostViewController: UIViewController {
    
    private var coordinator: FeedCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = . white
        
        // Создание barItem'а по которому будет открыто модальное окно.
        let logoutBarButtonItem = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(presentInfoViewController))
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
        coordinator = FeedCoordinatorImplementation(presenter: self, navigationController: navigationController ?? UINavigationController())
    }
    
    // Реализация открытия модального окна.
    @objc func presentInfoViewController() {
        coordinator.openInfoViewController()
    }
}

struct Post {
    let title: String
}
