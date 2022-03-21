//
//  PostViewController.swift
//  Navigation
//
//  Created by Илья on 28.11.2021.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = . white
        
        // Создание barItem'а по которому будет открыто модальное окно.
        let logoutBarButtonItem = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(presentInfoViewController))
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    // Реализация открытия модального окна.
    @objc func presentInfoViewController() {
        let infoViewController = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        present(infoNavigationController, animated: true, completion: nil)
    }
}

struct Post {
    let title: String
}
