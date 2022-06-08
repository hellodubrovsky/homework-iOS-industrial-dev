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
    }
    
    
    
    // MARK: - Private methods
    
    // Реализация открытия окна "Post" по нажатию кнопки.
    @objc private func buttonAction() {
        presenter.buttonPost()
        
        /* Код ниже, должен забрать к себе coordinator*/
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
