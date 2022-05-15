//
//  FeedView.swift
//  Navigation
//
//  Created by Илья on 15.05.2022.
//

import UIKit

final class FeedView: UIView {
    
    
    // MARK: - Public properties
    
    // Лейбл, отображающий статус правильности введенного пароля
    lazy var passwordStatusLabel: UILabel = {
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
    
    
    
    // MARK: - Private properties
    
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
        let button = CustomButton(title: "Go to post #1.", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1), cornerRadius: 20) { self.sendingChangingUiElements(element: .buttonPost) }
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(112.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // Cоздание кнопки "Переход к посту". (Вторая для стека)
    private lazy var buttonPostSecond: UIButton = {
        let button = CustomButton(title: "Go to post #2.", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1), cornerRadius: 20) { self.sendingChangingUiElements(element: .buttonPost) }
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
        let button = CustomButton(title: "Check", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.1), cornerRadius: 20, buttonAction: { self.sendingChangingUiElements(element: .buttonCheckPassword) })
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.yellow.cgColor
        return button
    }()
    
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        settingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        let subviews = [stackView, passwordTextField, buttonCheckPassword, passwordStatusLabel]
        let subviewsStack = [buttonPostFirst, buttonPostSecond]
        self.addSubviews(subviews)
        self.addArrangedSubviews(stack: stackView, views: subviewsStack)
        self.backgroundColor = UIColor(red: 0.53, green: 0.47, blue: 0.68, alpha: 0.1)
        installingConstants()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            passwordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonCheckPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonCheckPassword.heightAnchor.constraint(equalToConstant: 50),
            
            passwordStatusLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            passwordStatusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            passwordStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            passwordStatusLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}





// MARK: - Extension. Observer. Отправка изменений в FeedViewController для дальнейшей обработки.

extension FeedView {
    
    private enum elementUI {
        case buttonPost
        case buttonCheckPassword
    }
    
    // Отправка изменение.
    private func sendingChangingUiElements(element: elementUI) {
        let notificationCenter = NotificationCenter.default
        switch element {
        case .buttonPost:
            notificationCenter.post(name: Notification.Name("notificationForButtonPost"), object: nil)
        case .buttonCheckPassword:
            let textInPasswordTextView: [String: String] = ["text": passwordTextField.text!]
            notificationCenter.post(name: Notification.Name("notificationForButtonCheckPassword"), object: nil, userInfo: textInPasswordTextView)
        }
    }
}
