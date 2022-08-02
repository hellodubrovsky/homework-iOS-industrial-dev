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
        addObserversForPassword()
        self.presenter.set(view: self)
        self.coordinator = FeedCoordinatorImplementation(navigationController: navigationController ?? UINavigationController())
        
    }
    
    
    
    // MARK: - Private methods
    
    @objc private func buttonImagesScreenAction() {
        coordinator.openImageUserViewController()
    }
    
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
        notificationCenter.addObserver(self, selector: #selector(buttonImagesScreenAction), name: Notification.Name("notificationForButtonImagesUserScreen"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(changedTextInPasswordTextField), name: Notification.Name("notificationAboutChangedTextInPasswordTextField"), object: nil)
    }
    
    // Текст, введенный в textField пароля, отправляется в презентер, и уже там происходит проверка.
    @objc private func checkPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["text"] as? String else { preconditionFailure() }
        let notificationCenter = NotificationCenter.default
        do {
            try presenter.buttonCheckPassword(text: text)
            // Тут должен открываться новый экран
        } catch CheckPasswordPostErrors.invalidPassword {
            notificationCenter.post(name: Notification.Name("invalidPassword"), object: nil)
        } catch CheckPasswordPostErrors.invalidVerificationPassword {
            notificationCenter.post(name: Notification.Name("invalidVerificationPassword"), object: nil)
        } catch {
            print(error.localizedDescription)
            preconditionFailure()
        }
    }
    
    // Добавление наблюдателей (для пароля).
    private func addObserversForPassword() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(invalidPassword), name: Notification.Name("invalidPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(invalidVerificationPassword), name: Notification.Name("invalidVerificationPassword"), object: nil)
    }
    
    @objc
    private func invalidPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Введён неверный пароль"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc
    private func invalidVerificationPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Введён неверный проверочный пароль"
        mainView.passwordTextField.layer.borderColor = UIColor.red.cgColor
        // TODO: Здесь, по таймеру нужно убрать ошибку, и вернуть экран к первоначальному состоянию
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
