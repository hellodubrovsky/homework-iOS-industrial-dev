//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья on 27.11.2021.
//

import UIKit


final class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view = mainView
        addObserverForView()
        addObserversForPassword()
    }
    
    
    
    // MARK: - Private properties
    
    // Модель для проверки пароля.
    private let passwordModel = FeedModel()
    
    // Главная view
    private let mainView = FeedView()
    
    
    
    
    // MARK: - Private methods
    
    // Реализация открытия окна "Post" по нажатию кнопки.
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        let titlePost: Post = Post(title: "Post")
        postViewController.title = titlePost.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    // Добавление наблюдателей для управления действиями UI-элементов.
    private func addObserverForView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(buttonAction), name: Notification.Name("notificationForButtonPost"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.checkPassword(notification:)), name: Notification.Name("notificationForButtonCheckPassword"), object: nil)
    }
    
    // Текст, введенный в textField пароля, отправляется в бизнес слой, и уже там происходит проверка.
    @objc private func checkPassword(notification: NSNotification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        passwordModel.check(word: text)
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
