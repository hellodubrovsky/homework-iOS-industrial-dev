//
//  LogInViewController.swift
//  Navigation
//
//  Created by Илья on 06.01.2022.
//

import UIKit

// MARK: - LogInViewControllerDelegate

protocol LogInViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}





// MARK: - LogInspector

class LogInInspector: LogInViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}





// MARK: - LogInViewController

final class LogInViewController: UIViewController {
    
    // MARK: - Public properties
    var delegate: LogInViewControllerDelegate?
    
    
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        setupTapGesture()
    }
    
    
    
    // MARK: - Private properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var iconLogoVK: UIImageView = {
        let image = UIImage(named: "iconVK")!
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginInputTextField: UITextField = {
        let loginTextFileld = UITextField()
        loginTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        loginTextFileld.textColor = .black
        loginTextFileld.attributedPlaceholder = NSAttributedString(string: "Email of phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
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
    
    private lazy var passwordInputTextField: UITextField = {
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
    
    private lazy var inputFieldStackView: UIStackView = {
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
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.init(named: "colorBaseVK")
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(buttonLogInAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    // MARK: - Private methods
    
    // Обработка нажатия на кнопку "Log in"
    @objc private func buttonLogInAction() {
        guard (loginInputTextField.text?.isEmpty == false) else {
            displayingAnAlertWithWarningForTheLoginField()
            return
        }
        let userName = loginInputTextField.text!
        let userPassword = passwordInputTextField.text!
        
        #if DEBUG
        let cervice = TestUserService()
        #else
        let user = User(name: userName)
        let cervice = CurrentUserService(user: user)
        #endif
        
        guard let check = delegate?.check(login: userName, password: userPassword), check == true else {
            displayingAnAlertWithWarningForLoginAndPassword()
            return
        }
        let viewController = ProfileViewController(userService: cervice, userName: userName)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Показ алерта, информирующего о необходимости заполнения поля login
    private func displayingAnAlertWithWarningForTheLoginField() {
        let alert = UIAlertController(title: "Предупреждение", message: "Поле ввода логина не может быть пустым.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Показ алерта, информирующего о необходимости заполнения полей login или password
    private func displayingAnAlertWithWarningForLoginAndPassword() {
        
        var message: String = "Поле 'логин' или 'пароль' содержат некорректные значения."
        
        #if DEBUG
        message = message + "Подсказка для dev-сборки. Логин: login, Пароль: pass."
        #endif

        let alert = UIAlertController(title: "Предупреждение", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = . white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(iconLogoVK)
        contentView.addSubview(inputFieldStackView)
        contentView.addSubview(logInButton)
        inputFieldStackView.addArrangedSubview(loginInputTextField)
        inputFieldStackView.addArrangedSubview(passwordInputTextField)
        installingConstraints()
    }
    
    private func installingConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}





// MARK: - Keyboard Control

extension LogInViewController {
    
    // Observers keyboard.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    
    // Show/Hide keyboard method's.
    /* https://stackoverflow.com/questions/26689232/scrollview-and-keyboard-in-swift */
    
    @objc fileprivate func willShowKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc fileprivate func willHideKeyboard(_ notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    
    // Hiding the keyboard by tap.
    /* https://developer.apple.com/documentation/uikit/uiview/1622507-layoutifneeded */
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }

    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
        view.layoutIfNeeded()
    }
}
