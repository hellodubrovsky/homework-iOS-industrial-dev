//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья on 27.11.2021.
//

import UIKit


final class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        addObserversForPassword()
    }
    
    
    
    // MARK: - Private properties
    
    // Модель для проверки пароля.
    private let passwordModel = FeedModel()
    
    // Создание StackView с двумя кнопками.
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Cоздание кнопки "Переход к посту". (Первая для стека)
    private lazy var buttonPostFirst: UIButton = {
        let button = CustomButton(title: "Go to post #1.", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1), cornerRadius: 20) { self.buttonAction() }
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(112.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // Cоздание кнопки "Переход к посту". (Вторая для стека)
    private lazy var buttonPostSecond: UIButton = {
        let button = CustomButton(title: "Go to post #2.", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1), cornerRadius: 20) { self.buttonAction() }
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(112.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // Кастомный textField для ввода пароля
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(text: nil, textPlaceholder: "Write password...", colorPlaceholder: .gray, textColor: .white, radius: 20, borderWidth: 1, borderColor: .yellow)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Кастомная кнопка для проверки пароля
    private lazy var buttonCheckPassword: UIButton = {
        let button = CustomButton(title: "Check", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1), cornerRadius: 20, buttonAction: { self.passwordModel.check(word: self.passwordTextField.text!) })
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.yellow.cgColor
        return button
    }()
    
    // Лейбл, отображающий статус правильности введенного пароля
    private lazy var passwordStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.isHidden = true
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Private methods
    
    // Реализация открытия окна "Post" по нажатию кнопки.
    private func buttonAction() {
        let postViewController = PostViewController()
        let titlePost: Post = Post(title: "Post")
        postViewController.title = titlePost.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    // Добавление наблюдателей (для пароля).
    private func addObserversForPassword() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(correctPassword), name: Notification.Name("correctPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(incorrectPassword), name: Notification.Name("incorrectPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(emptyPassword), name: Notification.Name("emptyPassword"), object: nil)
    }
    
    @objc
    private func correctPassword() {
        passwordStatusLabel.isHidden = false
        passwordStatusLabel.text = "Correct Password"
        passwordStatusLabel.layer.borderColor = UIColor.green.cgColor
    }
    
    @objc
    private func incorrectPassword() {
        passwordStatusLabel.isHidden = false
        passwordStatusLabel.text = "Incorrect Password"
        passwordStatusLabel.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc
    private func emptyPassword() {
        passwordStatusLabel.isHidden = false
        passwordStatusLabel.text = "Empty Password"
        passwordStatusLabel.layer.borderColor = UIColor.purple.cgColor
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        title = "Feed"
        view.backgroundColor = UIColor(red: 0.53, green: 0.47, blue: 0.68, alpha: 0.1)
        view.addSubview(stackView)
        view.addSubview(passwordTextField)
        view.addSubview(buttonCheckPassword)
        view.addSubview(passwordStatusLabel)
        stackView.addArrangedSubview(buttonPostFirst)
        stackView.addArrangedSubview(buttonPostSecond)
        installingConstants()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            passwordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            buttonCheckPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            buttonCheckPassword.heightAnchor.constraint(equalToConstant: 50),
            
            passwordStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            passwordStatusLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            passwordStatusLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            passwordStatusLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
