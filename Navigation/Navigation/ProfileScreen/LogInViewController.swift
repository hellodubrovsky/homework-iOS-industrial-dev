//
//  LogInViewController.swift
//  Navigation
//
//  Created by Илья on 06.01.2022.
//

import UIKit

// MARK: - LogInViewControllerDelegate

protocol LogInViewControllerDelegate: AnyObject {
    func check(login: String, password: String, completion: @escaping (Result<Bool, AuthorizationErrors>) -> Void)
}




// MARK: - LogInViewControllerBrutForceDelegate

protocol LogInViewControllerBrutForceDelegate: AnyObject {
    func bruteForce(passwordToUnlock: String) -> String
}





// MARK: - LogInspector

final class LogInInspector: LogInViewControllerDelegate {
    func check(login: String, password: String, completion: @escaping (Result<Bool, AuthorizationErrors>) -> Void) {
        if login.isEmpty && password.isEmpty {
            completion(.failure(.emptyLofinOrPassword))
        } else if login.isEmpty {
            completion(.failure(.emptyLoginField))
        } else if password.isEmpty {
            completion(.failure(.emptyPassordField))
        } else if !Checker.shared.check(login: login, password: password) {
            completion(.failure(.incorrectPasswordOrLogin))
        } else {
            completion(.success(true))
        }
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
        self.coordinator = ProfileCoordinatorImplementation(navigationController: navigationController ?? UINavigationController())
    }
    
    
    
    // MARK: - Private properties
    
    private var coordinator: ProfileCoordinator!
    private var brutForceDelegate: LogInViewControllerBrutForceDelegate = BrutForcePassword()
    
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
        let button = CustomButton(title: "Log In", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.buttonLogInAction() }
        return button
    }()
    
    private lazy var brutforceButton: UIButton = {
        let button = CustomButton(title: "Brut force password", titleColor: .white, backgoundColor: .black, cornerRadius: 10, buttonAction: { self.brutforceAction() })
        return button
    }()
    
    private lazy var activitityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    
    // MARK: - Private methods
    
    // Обработка нажатия на кнопку "Log in"
    private func buttonLogInAction() {
       
        let userName: String = loginInputTextField.text!
        let userPassword: String = passwordInputTextField.text!
        
        #if DEBUG
        let service = TestUserService()
        #else
        let user = User(name: userName)
        let service = CurrentUserService(user: user)
        #endif
        
        delegate?.check(login: userName, password: userPassword, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.coordinator.openProfileScreen(service: service, userName: userName)
            case .failure(let error):
                switch error {
                case .emptyLofinOrPassword:
                    self?.displayingAnAlertWithWarningForTheLoginField(withText: "Поля ввода 'логина' и 'пароля' не могут быть пустыми.")
                case .emptyLoginField:
                    self?.displayingAnAlertWithWarningForTheLoginField(withText: "Поле ввода 'логина' не может быть пустым.")
                case .emptyPassordField:
                    self?.displayingAnAlertWithWarningForTheLoginField(withText: "Поле ввода 'пароля' не может быть пустым.")
                case .incorrectPasswordOrLogin:
                    self?.displayingAnAlertWithWarningForLoginAndPassword()
                }
            }
        })
    }
    
    // Показ алерта, информирующего о необходимости заполнения поля login
    private func displayingAnAlertWithWarningForTheLoginField(withText: String) {
        let alert = UIAlertController(title: "Предупреждение", message: withText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Показ алерта, информирующего о необходимости заполнения полей login или password
    private func displayingAnAlertWithWarningForLoginAndPassword() {
        
        var message: String = "Поле 'логин' или 'пароль' содержат некорректные значения."
        
        #if DEBUG
        message = message + "Подсказка для dev-сборки. Логин: login, Пароль: pas."
        #endif

        let alert = UIAlertController(title: "Предупреждение", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Подбор пароля
    private func brutforceAction() {
        self.activitityIndicator.startAnimating()
        DispatchQueue.global().async {
            let password = self.brutForceDelegate.bruteForce(passwordToUnlock: Checker.shared.refundPassword())
            DispatchQueue.main.async {
                self.passwordInputTextField.isSecureTextEntry = false
                self.passwordInputTextField.text = password
                self.activitityIndicator.stopAnimating()
            }
            // Через 5 секунд, скрываю текст в поле пароля
            sleep(5)
            DispatchQueue.main.async {
                self.passwordInputTextField.isSecureTextEntry = true
            }
        }
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
        
        #if DEBUG
        contentView.addSubview(brutforceButton)
        contentView.addSubview(activitityIndicator)
        #endif
        
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
            logInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        #if DEBUG
        NSLayoutConstraint.activate([
            brutforceButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16.0),
            brutforceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            brutforceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            brutforceButton.heightAnchor.constraint(equalToConstant: 50),
            
            activitityIndicator.centerYAnchor.constraint(equalTo: brutforceButton.centerYAnchor),
            activitityIndicator.trailingAnchor.constraint(equalTo: brutforceButton.trailingAnchor, constant: -16)
        ])
        #endif
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
