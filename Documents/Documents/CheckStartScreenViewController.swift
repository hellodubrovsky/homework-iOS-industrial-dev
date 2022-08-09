//
//  CheckStartScreenViewController.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation
import UIKit


protocol CheckStartScreenViewControllerInput: AnyObject {
    func resultCheckPassword(_ result: ResultCheckPassword)
}




final class CheckStartScreenViewController: UIViewController {
    
    // MARK: - Private properties
    
    // Модель для проверки пароля.
    private var presenter: CheckStartScreenPresenterInput
    private let mainView = CheckStartScreenView()
    private var coordinator: CheckStartScreenCoordinator!
    
    
    
    
    // MARK: - Public Initial
    
    init(presenter: CheckStartScreenPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view = mainView
        addObserverForView()
        self.presenter.set(view: self)
        self.coordinator = CheckStartScreenCoordinatorImplementation(navigationController: navigationController ?? UINavigationController())
        self.mainView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.definingPasswordEntryScreen()
    }
    
    
    
    // MARK: - Private methods
    
    /// Определение, какой экран для ввода пароля показать (проверка или регистрация).
    func definingPasswordEntryScreen() {
        self.mainView.passwordTextField.text?.removeAll()
        if self.presenter.checkingForExistenceOfPassword() {
            // Попадаем сюда, если у пользователя есть сохраненный пароль.
            self.mainView.passwordTextField.placeholder = "Введите пароль"
            self.mainView.buttonCheckPassword.setTitle("Проверить пароль", for: .normal)
            self.mainView.buttonCheckPassword.isHidden = false
            self.mainView.buttonCheckVerificationPassword.isHidden = true
        } else {
            // Попадаем сюда, если у пользователя нет сохраненного пароля.
            self.mainView.passwordTextField.placeholder = "Придумайте пароль"
            self.mainView.buttonCheckPassword.setTitle("Продолжить", for: .normal)
            self.mainView.buttonCheckPassword.isHidden = false
            self.mainView.buttonCheckVerificationPassword.isHidden = true
        }
    }
    
    /// При каждом изменении textFiled, убираем ошибку и изменяем цвет обводки на дефолтный.
    @objc private func changedTextInPasswordTextField() {
        mainView.passwordStatusLabel.isHidden = true
        mainView.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    /// Добавление наблюдателей для управления действиями UI-элементов.
    private func addObserverForView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.checkPassword(notification:)), name: Notification.Name("notificationForButtonCheckPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.checkVerificationPassword(notification:)), name: Notification.Name("notificationForButtonCheckVerificationPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(changedTextInPasswordTextField), name: Notification.Name("notificationAboutChangedTextInPasswordTextField"), object: nil)
    }
    
    /// Сравнение сохраненного пароля в системе, с введенным.
    @objc private func checkPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["text"] as? String else { preconditionFailure() }
        if self.presenter.checkingForExistenceOfPassword() {
            // Попадаем сюда, если у пользователя есть сохраненный пароль.
            do {
                try presenter.buttonCheckPassword(text: text)
                coordinator.openImagesUserTabBarController()
            } catch CheckPasswordPostErrors.invalidPassword {
                self.invalidPassword()
            } catch CheckPasswordPostErrors.incorrectSymbols {
                self.incorrectSymbolsInPassword()
            } catch {
                print(error.localizedDescription)
                preconditionFailure()
            }
        } else {
            
            /*  Попадаем сюда, если у пользователя нет сохраненного пароля.
                Запоминаем введенный пароль через презентер.
                Скрываем кнопку "Продолжить", и раскрываем кнопку проверки пароля.
            */
            
            do {
                try presenter.savingPasswordForComparison(text: text)
                self.mainView.passwordTextField.text?.removeAll()
                self.mainView.passwordTextField.placeholder = "Повторите пароль"
                self.mainView.buttonCheckPassword.isHidden = true
                self.mainView.buttonCheckVerificationPassword.isHidden = false
            } catch CheckPasswordPostErrors.incorrectSymbols {
                self.incorrectSymbolsInPassword()
            } catch {
                print(error.localizedDescription)
                preconditionFailure()
            }
        }
    }
    
    /// Сравнение ранее введенного пароля, с проверочным.
    @objc private func checkVerificationPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["verificationText"] as? String else { preconditionFailure() }
        guard presenter.comparisonOfVerificationPassword(text: text) == false else {
            coordinator.openImagesUserTabBarController()
            return
        }
        self.invalidVerificationPassword()
        self.mainView.passwordTextField.text?.removeAll()
        self.mainView.buttonCheckPassword.isHidden = false
        self.mainView.buttonCheckVerificationPassword.isHidden = true
        self.mainView.passwordTextField.placeholder = "Придумайте пароль"
        self.mainView.buttonCheckPassword.isEnabled = false
        self.mainView.buttonCheckPassword.alpha = 0.5
    }

    /// Показ ошибки, если введённый и сохраненный пароли, не совпадают.
    private func invalidPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Введён неверный пароль"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    /// Показ ошибки, если введённый и проверочный пароли, не совпадают.
    private func invalidVerificationPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Проверочный пароль был неверным. Попробуйсте снова"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    /// Показ ошибки, если введенный текст содержит знаки пробела.
    private func incorrectSymbolsInPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Пароль не может содержать пробелы"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    /// Делает кнопку "Проверки пароля" недоступной для нажатия, если текстовое поле содержит меньше 4 символов.
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let string = self.mainView.passwordTextField.text!
        if string.count >= 4 {
            self.mainView.buttonCheckPassword.isEnabled = true
            self.mainView.buttonCheckPassword.alpha = 1.0
        } else {
            self.mainView.buttonCheckPassword.isEnabled = false
            self.mainView.buttonCheckPassword.alpha = 0.5
        }
    }
}





// MARK: - FeedViewControllerInput

extension CheckStartScreenViewController: CheckStartScreenViewControllerInput {
    func resultCheckPassword(_ result: ResultCheckPassword) {
        let notificationCenter = NotificationCenter.default
        switch result {
        case .empty:
            notificationCenter.post(name: Notification.Name("emptyPassword"), object: nil)
        case .correct:
            notificationCenter.post(name: Notification.Name("correctPassword"), object: nil)
        case .incorrect:
            notificationCenter.post(name: Notification.Name("incorrectPassword"), object: nil)
        }
    }
}
