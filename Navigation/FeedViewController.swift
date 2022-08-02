//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья on 27.11.2021.
//

import UIKit


protocol FeedViewControllerInput: AnyObject {
    func resultCheckPassword(_ result: ResultCheckPassword)
}




final class FeedViewController: UIViewController {
    
    // MARK: - Private properties
    
    // Модель для проверки пароля.
    private var presenter: FeedPresenterInput
    private let mainView = FeedView()
    private var coordinator: FeedCoordinator!
    
    
    
    
    // MARK: - Public Initial
    
    init(presenter: FeedPresenterInput) {
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
        self.coordinator = FeedCoordinatorImplementation(navigationController: navigationController ?? UINavigationController())
        self.mainView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    
    // MARK: - Private methods
    
    @objc private func changedTextInPasswordTextField() {
        mainView.passwordStatusLabel.isHidden = true
        mainView.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // Реализация открытия окна "Post" по нажатию кнопки.
    @objc private func buttonAction() {
        presenter.buttonPost()
        coordinator.openPostViewController()
        mainView.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // Добавление наблюдателей для управления действиями UI-элементов.
    private func addObserverForView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(buttonAction), name: Notification.Name("notificationForButtonPost"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.checkPassword(notification:)), name: Notification.Name("notificationForButtonCheckPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(changedTextInPasswordTextField), name: Notification.Name("notificationAboutChangedTextInPasswordTextField"), object: nil)
    }
    
    // Текст, введенный в textField пароля, отправляется в презентер, и уже там происходит проверка.
    @objc private func checkPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["text"] as? String else { preconditionFailure() }
        do {
            try presenter.buttonCheckPassword(text: text)
            coordinator.openImageUserViewController()
        } catch CheckPasswordPostErrors.invalidPassword {
            self.invalidPassword()
        } catch CheckPasswordPostErrors.invalidVerificationPassword {
            self.invalidVerificationPassword()
        } catch CheckPasswordPostErrors.incorrectSymbols {
            self.incorrectSymbolsInPassword()
        } catch {
            print(error.localizedDescription)
            preconditionFailure()
        }
    }

    private func invalidPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Введён неверный пароль"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    private func invalidVerificationPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Введён неверный проверочный пароль"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
        // TODO: Здесь, по таймеру нужно убрать ошибку, и вернуть экран к первоначальному состоянию
    }
    
    private func incorrectSymbolsInPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Пароль не может содержать пробелы"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    // Делает кнопку "Проверки пароля" недоступной для нажатия, если текстовое поле содержит меньше 4 символов.
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

extension FeedViewController: FeedViewControllerInput {
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
