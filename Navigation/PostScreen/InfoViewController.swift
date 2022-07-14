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
        let button = CustomButton(title: "Show alert", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.buttonAlertAction() }
        return button
    }()
    
    private lazy var titleUserLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.init(named: "colorBaseVK")!.cgColor
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.init(named: "colorBaseVK")!.cgColor
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    // Загрузка данных из сети.
    private func loadingData() {
        // Загрузка данных для titleUserLabel.
        NetworkService.loadData(stringURL: "https://jsonplaceholder.typicode.com/todos/") { [weak self] data in
            if let uwrappedData = data {
                do {
                    let serializedDictionary = try JSONSerialization.jsonObject(with: uwrappedData, options: [])
                    if let dictionary = serializedDictionary as? [[String: Any]], let title = dictionary.randomElement()!["title"] as? String {
                        DispatchQueue.main.async {
                            self?.titleUserLabel.text = " " + title
                        }
                    }
                } catch let error {
                    print("⚠️ Error:", String(describing: error))
                }
            } else {
                print("⚠️ Warning: Data empty.")
            }
        }
        
        // Загрузка данных для orbitalPeriodUserLabel.
        NetworkService.loadData(stringURL: "https://swapi.dev/api/planets/1") { [weak self] data in
            if let unwrappedData = data {
                do {
                    let planet = try JSONDecoder().decode(InfoModel.self, from: unwrappedData)
                    DispatchQueue.main.async {
                        self?.orbitalPeriodLabel.text = " The orbital period of the planet '\(planet.name)' = \(planet.orbitalPeriod)"
                    }
                } catch let error {
                    print("⚠️ Error:", String(describing: error))
                }
            } else {
                print("⚠️ Warning: Data empty.")
            }
        }
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        self.title = "Info"
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        view.addSubviews([buttonShowAlert, titleUserLabel, orbitalPeriodLabel])
        installingConstants()
        loadingData()
    }
    
    // Настройка констрейнтов
    private func installingConstants() {
        NSLayoutConstraint.activate([
            buttonShowAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonShowAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonShowAlert.widthAnchor.constraint(equalToConstant: 200),
            buttonShowAlert.heightAnchor.constraint(equalToConstant: 40),
            
            titleUserLabel.topAnchor.constraint(equalTo: buttonShowAlert.bottomAnchor, constant: 16),
            titleUserLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleUserLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleUserLabel.heightAnchor.constraint(equalToConstant: 40),
            
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleUserLabel.bottomAnchor, constant: 16),
            orbitalPeriodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orbitalPeriodLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            orbitalPeriodLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
