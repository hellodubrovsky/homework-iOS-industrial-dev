//
//  AuthorizationViewController.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import UIKit


// MARK: - AuthorizationCheckerDelegate

protocol AuthorizationCheckerDelegate: AnyObject {
    func check(login: String, password: String, completion: @escaping (Result<Bool, AuthorizationErrors>) -> Void)
}





// MARK: - AuthorizationBrutForceDelegate

protocol AuthorizationBrutForceDelegate: AnyObject {
    func bruteForce(passwordToUnlock: String) -> String
}





// MARK: - AuthorizationViewController

class AuthorizationViewController: UIViewController {

    
    // MARK: Private properties
    private let mainView = AuthorizationView()
    private let coordinator: ProfileCoordinator!
    private let authorizationDelegate: AuthorizationCheckerDelegate!
    private let brutForceDelegate: AuthorizationBrutForceDelegate!
    
    
    
    
    // MARK: Init
    init(coordinator: ProfileCoordinator, authorizationDelegate: AuthorizationCheckerDelegate, brutForceDelegate: AuthorizationBrutForceDelegate) {
        self.coordinator = coordinator
        self.authorizationDelegate = authorizationDelegate
        self.brutForceDelegate = brutForceDelegate
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        navigationController?.navigationBar.tintColor = . white
        navigationController?.navigationBar.isHidden = true
        self.coordinator.set(navigationController: self.navigationController!)
        self.addObserverForView()
    }
    
    
    
    // MARK: Private methods
    
    // Добавление наблюдателей для управления действиями UI-элементов.
    private func addObserverForView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(buttonLogInAction), name: Notification.Name("notificationForButtonLogIn"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(brutForceAction), name: Notification.Name("notificationForButtonBrutForce"), object: nil)
    }
    
    // Обработка нажатия на кнопку "Log in"
    @objc private func buttonLogInAction() {
        let userLogin: String = mainView.loginInputTextField.text!
        let userPassword: String = mainView.passwordInputTextField.text!
        
        #if DEBUG
        let userService = TestUserService()
        #else
        let user = User(name: userName)
        let userService = CurrentUserService(user: user)
        #endif
        
        self.authorizationDelegate.check(login: userLogin, password: userPassword) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.coordinator.openProfileScreen(service: userService, userName: userLogin)
            case .failure(let error):
                switch error {
                case .emptyLofinOrPassword:
                    self.displayingAnAlertWithWarningForTheLoginField(withText: "Поля ввода 'логина' и 'пароля' не могут быть пустыми.")
                case .emptyLoginField:
                    self.displayingAnAlertWithWarningForTheLoginField(withText: "Поле ввода 'логина' не может быть пустым.")
                case .emptyPassordField:
                    self.displayingAnAlertWithWarningForTheLoginField(withText: "Поле ввода 'пароля' не может быть пустым.")
                case .incorrectPasswordOrLogin:
                    self.displayingAnAlertWithWarningForLoginAndPassword()
                }
            }
        }
    }
    
    // Подбор пароля
    @objc private func brutForceAction() {
        mainView.activitityIndicator.startAnimating()
        DispatchQueue.global().async {
            let password = self.brutForceDelegate.bruteForce(passwordToUnlock: Checker.shared.refundPassword())
            DispatchQueue.main.async {
                self.mainView.passwordInputTextField.isSecureTextEntry = false
                self.mainView.passwordInputTextField.text = password
                self.mainView.activitityIndicator.stopAnimating()
            }
            // Через 5 секунд, скрывается текст в поле пароля
            sleep(5)
            DispatchQueue.main.async {
                self.mainView.passwordInputTextField.isSecureTextEntry = true
            }
        }
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
}
