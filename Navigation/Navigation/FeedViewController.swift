//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья on 27.11.2021.
//

import UIKit


class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = UIColor(red: 0.53, green: 0.47, blue: 0.68, alpha: 0.1)
        view.addSubview(stackView)
        stackView.addArrangedSubview(buttonPostFirst)
        stackView.addArrangedSubview(buttonPostSecond)
        addingLayoutConstraints()
    }
    
    // MARK: - Private object's
    
    // Создание StackView с двумя кнопками.
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10.0
        return stack
    }()
    
    // Cоздание кнопки "Переход к посту". (Первая для стека)
    private let buttonPostFirst: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        button.setTitle("Go to post. #1", for: .normal)
        button.backgroundColor = UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(112.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // Cоздание кнопки "Переход к посту". (Вторая для стека)
    private let buttonPostSecond: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        button.setTitle("Go to post. #2", for: .normal)
        button.backgroundColor = UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: CGFloat(255.0 / 255.0), green: CGFloat(170.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // MARK: - Private method's
    
    // Реализация открытия окна "Post" по нажатию кнопки.
    @objc private func buttonAction(sender: UIButton!) {
        let postViewController = PostViewController()
        let titlePost: Post = Post(title: "Post")
        postViewController.title = titlePost.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func addingLayoutConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}
