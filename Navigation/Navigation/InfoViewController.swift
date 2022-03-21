//
//  InfoViewController.swift
//  Navigation
//
//  Created by Илья on 28.11.2021.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.61, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.tintColor = . white
        self.title = "Info"
        view.addSubview(buttonShowAlert)
        addingLayoutConstraints()
    }
    
    // MARK: - Private object's
    
    // Cоздание кнопки "Показать алерт".
    private let buttonShowAlert: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.57, green: 0.62, blue: 0.70, alpha: 0.5)
        button.layer.borderColor = UIColor(red: CGFloat(253.0 / 255.0), green: CGFloat(112.0 / 255.0), blue: CGFloat(20.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        button.setTitle("Show alert", for: .normal)
        button.addTarget(self, action: #selector(buttonAlertAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private method's
    
    // Показ алерта при нажатии на кнопку "Показать алерт".
    @objc private func buttonAlertAction(sender: UIButton) {
        let buttonClickOK = { (_: UIAlertAction) -> Void in print("[UIAlertAction] --> Нажата кнопка 'ОК'.") }
        let buttonClickCancel = { (_: UIAlertAction) -> Void in print("[UIAlertAction] --> Нажата кнопка 'Назад'.") }
        let alert = UIAlertController(title: "Title", message: "Text alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonClickOK))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: buttonClickCancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addingLayoutConstraints() {
        buttonShowAlert.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonShowAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonShowAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonShowAlert.widthAnchor.constraint(equalToConstant: 200),
            buttonShowAlert.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
