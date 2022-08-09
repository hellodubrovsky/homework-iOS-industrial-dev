//
//  UpdatePasswordViewController.swift
//  Navigation
//
//  Created by Илья on 09.08.2022.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    
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
        let button = CustomButton(title: "", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10, buttonAction: {  })
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    // Кастомная кнопка для проверки пароля
    lazy var buttonCheckVerificationPassword: UIButton = {
        let button = CustomButton(title: "Проверить пароль", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10, buttonAction: {  })
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Изменение пароля"
        settingView()
    }
    

    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        let subviews = [passwordTextField, buttonCheckPassword, passwordStatusLabel, buttonCheckVerificationPassword]
        view.addSubviews(subviews)
        view.backgroundColor = .white
        installingConstants()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonCheckPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonCheckPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckVerificationPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            buttonCheckVerificationPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonCheckVerificationPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonCheckVerificationPassword.heightAnchor.constraint(equalToConstant: 50),
            
            passwordStatusLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -6),
            passwordStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordStatusLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

}
