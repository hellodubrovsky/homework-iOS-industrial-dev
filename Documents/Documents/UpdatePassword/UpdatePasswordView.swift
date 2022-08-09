//
//  UpdatePasswordView.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation
import UIKit


final class UpdatePasswordView: UIView {
    
    
    // MARK: - Public properties
    
    // Лейбл, отображающий статус правильности введенного пароля
    lazy var passwordStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
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
    
    // Кастомная кнопка для проверки пароля
    lazy var buttonCheckPassword: UIButton = {
        let button = CustomButton(title: "", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10, buttonAction: { self.sendingChangingUiElements(element: .buttonCheckPassword) })
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    // Кастомная кнопка для проверки пароля
    lazy var buttonCheckVerificationPassword: UIButton = {
        let button = CustomButton(title: "Проверить пароль", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10, buttonAction: { self.sendingChangingUiElements(element: .buttonCheckVerificationPassword) })
        button.isHidden = true
        return button
    }()
    
    // Логотип ВК
    lazy var iconLogoVK: UIImageView = {
        let image = UIImage(named: "iconVK")!
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        settingView()
        passwordTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        let subviews = [passwordTextField, buttonCheckPassword, passwordStatusLabel, buttonCheckVerificationPassword, iconLogoVK]
        self.addSubviews(subviews)
        self.backgroundColor = .white
        installingConstants()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            
            passwordTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            iconLogoVK.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -120.0),
            iconLogoVK.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconLogoVK.widthAnchor.constraint(equalToConstant: 100),
            iconLogoVK.heightAnchor.constraint(equalToConstant: 100),
            
            buttonCheckPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonCheckPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonCheckPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckVerificationPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckVerificationPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonCheckVerificationPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonCheckVerificationPassword.heightAnchor.constraint(equalToConstant: 50),
            
            passwordStatusLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -6),
            passwordStatusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordStatusLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}





// MARK: - Extension. Observer. Отправка изменений в FeedViewController для дальнейшей обработки.

extension UpdatePasswordView {
    
    private enum elementUI {
        case buttonCheckPassword
        case buttonCheckVerificationPassword
        case changedTextInPasswordTextField
    }
    
    // Отправка изменение.
    private func sendingChangingUiElements(element: elementUI) {
        let notificationCenter = NotificationCenter.default
        switch element {
        case .buttonCheckPassword:
            let textInPasswordTextView: [String: String] = ["text": passwordTextField.text!]
            notificationCenter.post(name: Notification.Name("notificationForButtonCheckPassword"), object: nil, userInfo: textInPasswordTextView)
        case .buttonCheckVerificationPassword:
            let textInPasswordTextView: [String: String] = ["verificationText": passwordTextField.text!]
            notificationCenter.post(name: Notification.Name("notificationForButtonCheckVerificationPassword"), object: nil, userInfo: textInPasswordTextView)
        case .changedTextInPasswordTextField:
            notificationCenter.post(name: Notification.Name("notificationAboutChangedTextInPasswordTextField"), object: nil)
        }
    }
    
    // Отправка события о том, что текстовое поле пароля изменилось.
    @objc private func editingChanged(_ textField: UITextField) {
        self.sendingChangingUiElements(element: .changedTextInPasswordTextField)
    }
}

    
    
