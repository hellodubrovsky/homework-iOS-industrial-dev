//
//  AuthorizationView.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import UIKit

class AuthorizationView: UIView {
    
    
    // MARK: Public properties (UI)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Поле ввода логина
    lazy var loginInputTextField: UITextField = {
        let loginTextFileld = UITextField()
        loginTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        loginTextFileld.textColor = .black
        loginTextFileld.attributedPlaceholder = NSAttributedString(string: "Phone number or email address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        loginTextFileld.font = .systemFont(ofSize: 16.0)
        loginTextFileld.tintColor = UIColor(named: "colorBaseVK")
        loginTextFileld.autocapitalizationType = .none
        loginTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        loginTextFileld.leftViewMode = .always
        loginTextFileld.layer.borderWidth = 0.5
        loginTextFileld.layer.borderColor = UIColor.lightGray.cgColor
        loginTextFileld.translatesAutoresizingMaskIntoConstraints = false
        return loginTextFileld
    }()
    
    // Поле ввода пароля
    lazy var passwordInputTextField: UITextField = {
        let passworfTextFileld = UITextField()
        passworfTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        passworfTextFileld.textColor = .black
        passworfTextFileld.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passworfTextFileld.font = .systemFont(ofSize: 16.0)
        passworfTextFileld.tintColor = UIColor(named: "colorBaseVK")
        passworfTextFileld.autocapitalizationType = .none
        passworfTextFileld.isSecureTextEntry = true
        passworfTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        passworfTextFileld.leftViewMode = .always
        passworfTextFileld.translatesAutoresizingMaskIntoConstraints = false
        return passworfTextFileld
    }()
    
    // Кнопка авторизация
    lazy var logInButton: UIButton = {
        let button = CustomButton(title: "Log In", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.sendingChangingUiElements(element: .buttonLogIn) }
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    // Кнопка регистрации
    lazy var signUpButton: UIButton = {
        let button = CustomButton(title: "Sign Up", titleColor: .white, backgoundColor: .black, cornerRadius: 10) { self.sendingChangingUiElements(element: .buttonSignUp) }
        return button
    }()
    
    // Стек, внутри которого находится поля с вводом логина и пароля
    lazy var inputFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.spacing = 0.5
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    // MARK: Private properties (UI)
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // Логотип ВК
    private lazy var iconLogoVK: UIImageView = {
        let image = UIImage(named: "iconVK")!
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    

    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Private methods (set view)
    
    private func setView() {
        self.backgroundColor = .white
        self.addSubviews([scrollView, contentView, iconLogoVK, inputFieldStackView, logInButton, signUpButton])
        self.addArrangedSubviews(stack: inputFieldStackView, views: [loginInputTextField, passwordInputTextField])
        installingConstraints()
    }
    
    private func installingConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            iconLogoVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            iconLogoVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconLogoVK.widthAnchor.constraint(equalToConstant: 100),
            iconLogoVK.heightAnchor.constraint(equalToConstant: 100),
            
            inputFieldStackView.topAnchor.constraint(equalTo: iconLogoVK.bottomAnchor, constant: 120),
            inputFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            inputFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            inputFieldStackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: inputFieldStackView.bottomAnchor, constant: 16.0),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16.0),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}





// MARK: - Send action buttons

extension AuthorizationView {
    
    private enum elementUI {
        case buttonLogIn
        case buttonSignUp
    }
    
    // Отправка события нажатия на определенную кнопку.
    private func sendingChangingUiElements(element: elementUI) {
        let notificationCenter = NotificationCenter.default
        switch element {
        case .buttonLogIn:
            notificationCenter.post(name: Notification.Name("notificationForButtonLogIn"), object: nil)
        case .buttonSignUp:
            notificationCenter.post(name: Notification.Name("notificationForButtonSignUp"), object: nil)
        }
    }
}
