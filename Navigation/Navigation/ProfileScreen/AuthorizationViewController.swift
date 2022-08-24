//
//  AuthorizationViewController.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import UIKit
import FirebaseAuth


// MARK: - AuthorizationCheckerDelegate

protocol AuthorizationCheckerDelegate: AnyObject {
    func checkCredentials(login: String, password: String, completion: @escaping (Result<AuthorizationModel, Error>) -> Void)
    func signUp(login: String, password: String, completion: @escaping (Result<AuthorizationModel, Error>) -> Void)
    func checkingStatusOfAutomaticAuthorization(completion: @escaping (Result<AuthorizationModelRealm, AuthorizationErrors>) -> Void)
    func saveUserInDatabase(_ user: AuthorizationModel)
}





// MARK: - AuthorizationViewController

class AuthorizationViewController: UIViewController {

    
    // MARK: Private properties
    private let mainView = AuthorizationView()
    private let coordinator: ProfileCoordinator!
    private let authorizationDelegate: AuthorizationCheckerDelegate!
    private var statusAuthomaticAuthrorization: Bool?
    private let userDefaults = UserDefaults.standard
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .black
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    
    
    // MARK: Init
    init(coordinator: ProfileCoordinator, authorizationDelegate: AuthorizationCheckerDelegate) {
        self.coordinator = coordinator
        self.authorizationDelegate = authorizationDelegate
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = . white
        navigationController?.navigationBar.isHidden = true
        self.setLoadingView()
        self.coordinator.set(navigationController: self.navigationController!)
        self.checkingExistenceOfUser()
    }
    
    
    
    // MARK: Private methods
    
    private func setLoadingView() {
        self.view.backgroundColor = .white
        self.view.addSubview(activityIndicator)
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    private func setLoadedView() {
        self.view = mainView
        self.addObserverForView()
        self.addObserverForChangesToTextFields()
    }
    
    // Проверка, имеется ли БД сохраненный пользователь. В зависимости от этого, показываю автоматическую авторизацию или обычную.
    private func checkingExistenceOfUser() {
        self.authorizationDelegate.checkingStatusOfAutomaticAuthorization() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                let user = User(name: user.login)
                let userService = CurrentUserService(user: user)
                self.coordinator.openProfileScreen(service: userService, userName: userService.user.name)
            case .failure(_):
                self.setLoadedView()
            }
        }
    }
    
    // Добавление наблюдателей для управления действиями UI-элементов.
    private func addObserverForView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(buttonLogInAction), name: Notification.Name("notificationForButtonLogIn"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(buttonSingUpAction), name: Notification.Name("notificationForButtonSignUp"), object: nil)
    }
    
    // Наблюление за изменениями полей ввода логина и пароля.
    private func addObserverForChangesToTextFields() {
        self.mainView.loginInputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.mainView.passwordInputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // Делает кнопку "LogIn" недоступной для нажатия, если текстовые поля незаполнены.
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if self.mainView.loginInputTextField.text!.isEmpty || self.mainView.passwordInputTextField.text!.isEmpty {
            self.mainView.logInButton.isEnabled = false
            self.mainView.logInButton.alpha = 0.5
        } else {
            self.mainView.logInButton.isEnabled = true
            self.mainView.logInButton.alpha = 1.0
        }
    }
    
    // Получение введенных логина и пароля
    private func getEnteredLoginAndPassword() -> (String, String) {
        let login: String = mainView.loginInputTextField.text!
        let password: String = mainView.passwordInputTextField.text!
        return (login, password)
    }
    
    // Обработка нажатия на кнопку "Sing Up"
    @objc private func buttonSingUpAction() {
        let user = User(name: getEnteredLoginAndPassword().0)
        let userService = CurrentUserService(user: user)
        
        self.authorizationDelegate.signUp(login: getEnteredLoginAndPassword().0, password: getEnteredLoginAndPassword().1) { [weak self] result in
            switch result {
            case .success(let user):
                self?.coordinator.openProfileScreen(service: userService, userName: user.login)
            case .failure(let error):
                self?.displayingAnAlertWithWarningForTheLoginField(withText: error.localizedDescription)
            }
        }
    }
    
    // Обработка нажатия на кнопку "Log in"
    @objc private func buttonLogInAction() {
        #if DEBUG
        let userService = TestUserService()
        #else
        let user = User(name: getEnteredLoginAndPassword().0)
        let userService = CurrentUserService(user: user)
        #endif
        
        self.authorizationDelegate.checkCredentials(login: getEnteredLoginAndPassword().0, password: getEnteredLoginAndPassword().1) { [weak self] result in
            switch result {
            case .success(_):
                self?.coordinator.openProfileScreen(service: userService, userName: userService.user.name)
            case .failure(let error):
                self?.displayingAnAlertWithWarningForTheLoginField(withText: error.localizedDescription)
            }
        }
    }

    // Показ информационного алерта.
    private func displayingAnAlertWithWarningForTheLoginField(withText: String) {
        let alert = UIAlertController(title: "Warning", message: withText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
