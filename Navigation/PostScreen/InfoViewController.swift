//
//  InfoViewController.swift
//  Navigation
//
//  Created by Илья on 28.11.2021.
//

import UIKit

final class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
    }
    
    
    
    // MARK: - Private properties
    
    // Cоздание кнопки "Показать алерт".
    private lazy var buttonShowAlert: UIButton = {
        let button = CustomButton(title: "Show alert", titleColor: .white, backgoundColor: UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.5), cornerRadius: 20) { self.buttonAlertAction() }
        button.layer.borderColor = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(112.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    
    
    // MARK: - Private methods
    
    // Показ алерта при нажатии на кнопку "Показать алерт".
    private func buttonAlertAction() {
        let buttonClickOK = { (_: UIAlertAction) -> Void in print("[UIAlertAction] --> Нажата кнопка 'ОК'.") }
        let buttonClickCancel = { (_: UIAlertAction) -> Void in print("[UIAlertAction] --> Нажата кнопка 'Назад'.") }
        let alert = UIAlertController(title: "Title", message: "Text alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonClickOK))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: buttonClickCancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        self.title = "Info"
        view.backgroundColor = UIColor(red: 0.61, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(buttonShowAlert)
        installingConstants()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            buttonShowAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonShowAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonShowAlert.widthAnchor.constraint(equalToConstant: 200),
            buttonShowAlert.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
