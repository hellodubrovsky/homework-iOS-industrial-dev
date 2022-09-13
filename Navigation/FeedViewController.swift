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
    
    /// Очистка текстового поля ввода пароля. Будет очищаться через установленное время.
    func clearTextField(withTimeInterval: Double) {
        self.mainView.timerIndicator.isHidden = false
        var timerTime = Int(withTimeInterval)
        let timerIndicatorText = "До очистки поля ввода пароля осталось: "
        self.mainView.timerIndicator.text =  timerIndicatorText + String(timerTime)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            timerTime -= 1
            self.mainView.timerIndicator.text = timerIndicatorText + String(timerTime)
            if timerTime == 0 {
                self.mainView.timerIndicator.text = "Поле ввода пароля очищено, от чужих глаз."
                self.mainView.passwordTextField.text = nil
            } else if timerTime == -1 {
                self.mainView.timerIndicator.isHidden = true
                timer.invalidate()
            }
        }
    }
    
    
    
    // MARK: - Private methods
    
    @objc private func buttonImagesScreenAction() {
        coordinator.openImageUserViewController()
    }
    
    // Реализация открытия окна "Post" по нажатию кнопки.
    @objc private func buttonAction() {
        presenter.buttonPost()
        coordinator.openPostViewController()
    }
    
    // Добавление наблюдателей для управления действиями UI-элементов.
    private func addObserverForView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(buttonAction), name: Notification.Name("notificationForButtonPost"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.checkPassword(notification:)), name: Notification.Name("notificationForButtonCheckPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(buttonImagesScreenAction), name: Notification.Name("notificationForButtonImagesUserScreen"), object: nil)
    }
    
    // Текст, введенный в textField пароля, отправляется в презентер, и уже там происходит проверка.
    @objc private func checkPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["text"] as? String else { preconditionFailure() }
        let notificationCenter = NotificationCenter.default
        do {
            try presenter.buttonCheckPassword(text: text)
            notificationCenter.post(name: Notification.Name("correctPassword"), object: nil)
        } catch CheckPasswordPostErrors.emptyPassordField {
            notificationCenter.post(name: Notification.Name("emptyPassword"), object: nil)
        } catch CheckPasswordPostErrors.incorrectPassword {
            notificationCenter.post(name: Notification.Name("incorrectPassword"), object: nil)
        } catch {
            print(error.localizedDescription)
            preconditionFailure()
        }
    }
    
    // Добавление наблюдателей (для пароля).
    private func addObserversForPassword() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(correctPassword), name: Notification.Name("correctPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(incorrectPassword), name: Notification.Name("incorrectPassword"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(emptyPassword), name: Notification.Name("emptyPassword"), object: nil)
    }
    
    @objc
    private func correctPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Correct Password"
        mainView.passwordStatusLabel.layer.borderColor = UIColor.green.cgColor
//        runTimer()
        clearTextField(withTimeInterval: 5)
    }
    
    @objc
    private func incorrectPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Incorrect Password"
        mainView.passwordStatusLabel.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc
    private func emptyPassword() {
        mainView.passwordStatusLabel.isHidden = false
        mainView.passwordStatusLabel.text = "Empty Password"
        mainView.passwordStatusLabel.layer.borderColor = UIColor.purple.cgColor
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
