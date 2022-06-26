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
    private var timer: Timer?
    
    
    
    
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
        var timerTime = withTimeInterval
        self.mainView.timerIndicator.text = "До очистки поля ввода пароля осталось: \(timerTime)"
        
        DispatchQueue.global().async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                timerTime -= 1
                DispatchQueue.main.async {
                    self.mainView.timerIndicator.text = "До очистки поля ввода пароля осталось: \(timerTime)"
                }
                if timerTime == 0 {
                    DispatchQueue.main.async {
                        self.mainView.timerIndicator.text = "Поле ввода пароля очищено, от чужих глаз."
                        self.mainView.passwordTextField.text = ""
                    }
                    print("Очистка текста в поле ввода пароля.")
                } else if timerTime == -1 {
                    DispatchQueue.main.async {
                        self.mainView.timerIndicator.isHidden = true
                    }
                    self.timer?.invalidate()
                    self.timer = nil
                    print("Таймер убит.")
                }
            }
            guard let timer = self.timer else { return }
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }
        
    }
    
    
    
    // MARK: - Private methods
    
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
    }
    
    // Текст, введенный в textField пароля, отправляется в презентер, и уже там происходит проверка.
    @objc private func checkPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        presenter.buttonCheckPassword(text: text)
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
