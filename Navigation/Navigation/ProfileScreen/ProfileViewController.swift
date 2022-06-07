//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья on 27.11.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .systemGray
        navigationController?.navigationBar.tintColor = . white
        view.addSubview(profileView)
        view.addSubview(newButton)
        addingLayoutConstraints()
    }
    
    // MARK: - Private object's
    /* Пока нет понимания, что это и для чего нужна эта кнопка (newButton).
       Необходимо реализовать тут: https://github.com/netology-code/iosui-homeworks/tree/iosui-8/2.2 в задании #3.
       После того, как будет получена дополнительная информация, название кнопки необходимо изменить. */
    
    private let newButton: UIButton = {
        let button = UIButton()
        button.setTitle("NewButton", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor(ciColor: .black).cgColor
        return button
    }()
    
    // MARK: - Private method's
    private func addingLayoutConstraints() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        newButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileView.heightAnchor.constraint(equalToConstant: 220),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
