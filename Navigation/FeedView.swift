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
        label.textColor = .black
        label.backgroundColor = .systemGray2
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.8
        label.textAlignment = .center
        label.alpha = 0.7
        label.isHidden = true
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timerIndicator: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .green
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.alpha = 0.7
        label.isHidden = true
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Кастомный textField для ввода пароля
    let passwordTextField: UITextField = {
        let textField = CustomTextField(text: nil, textPlaceholder: "Write password...", colorPlaceholder: .gray, textColor: .black, radius: 10, borderWidth: 0.5, borderColor: UIColor.lightGray)
        textField.font = .systemFont(ofSize: 16.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        let button = CustomButton(title: "Go to post #1.", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.sendingChangingUiElements(element: .buttonPost) }
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // Cоздание кнопки "Переход к посту". (Вторая для стека)
    private lazy var buttonPostSecond: UIButton = {
        let button = CustomButton(title: "Go to post #2.", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.sendingChangingUiElements(element: .buttonPost) }
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    // Кастомная кнопка для проверки пароля
    private lazy var buttonCheckPassword: UIButton = {
        let button = CustomButton(title: "Check", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10, buttonAction: { self.sendingChangingUiElements(element: .buttonCheckPassword) })
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
        let subviews = [stackView, passwordTextField, buttonCheckPassword, passwordStatusLabel, timerIndicator]
        let subviewsStack = [buttonPostFirst, buttonPostSecond]
        self.addSubviews(subviews)
        self.addArrangedSubviews(stack: stackView, views: subviewsStack)
        self.backgroundColor = .white
        installingConstants()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            passwordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonCheckPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonCheckPassword.heightAnchor.constraint(equalToConstant: 50),
            
            passwordStatusLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            passwordStatusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordStatusLabel.heightAnchor.constraint(equalToConstant: 50),
            
            timerIndicator.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            timerIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timerIndicator.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            timerIndicator.heightAnchor.constraint(equalToConstant: 30),
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
