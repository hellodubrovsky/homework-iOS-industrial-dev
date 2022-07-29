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
}





// MARK: - AuthorizationViewController

class AuthorizationViewController: UIViewController {

    
    // MARK: Private properties
    private let mainView = AuthorizationView()
    private let coordinator: ProfileCoordinator!
    private let authorizationDelegate: AuthorizationCheckerDelegate!
    
    
    
    
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
        view = mainView
        navigationController?.navigationBar.tintColor = . white
        navigationController?.navigationBar.isHidden = true
        self.coordinator.set(navigationController: self.navigationController!)
        self.addObserverForView()
        self.addObserverForChangesToTextFields()
    }
    
    
    
    // MARK: Private methods
    
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
                self?.coordinator.openProfileScreen(service: userService, userName: user.email)
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
