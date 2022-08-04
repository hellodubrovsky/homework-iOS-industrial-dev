//
//  SettingsView.swift
//  Navigation
//
//  Created by Илья on 04.08.2022.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func switchStatusChanged(on: Bool)
    func pressingButtonToOpenPasswordChangeWindow()
}

class SettingsView: UIView {
    
    
    // MARK: Private properties
    private weak var delegate: SettingsViewDelegate?
    
    private let labelSorting: UILabel = {
        let label = UILabel()
        label.text = "Сортировать по алфавиту"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var switchSorting: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(switchActionChanged), for: .touchUpInside)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
    }()
    
    private let buttonEditPassword: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить пароль", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonActionEditPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: Initial
    
    init(delegate: SettingsViewDelegate ,sortingStatus: Bool) {
        self.delegate = delegate
        self.switchSorting.isOn = sortingStatus
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private methods
    
    private func setView() {
        self.backgroundColor = .white
        self.addSubviews([labelSorting, switchSorting, buttonEditPassword])
        self.installingConstraints()
    }
    
    private func installingConstraints() {
        NSLayoutConstraint.activate([
            labelSorting.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelSorting.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            switchSorting.centerYAnchor.constraint(equalTo: labelSorting.centerYAnchor),
            switchSorting.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            buttonEditPassword.topAnchor.constraint(equalTo: labelSorting.bottomAnchor, constant: 20),
            buttonEditPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonEditPassword.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func switchActionChanged() {
        self.delegate?.switchStatusChanged(on: switchSorting.isOn)
    }
    
    @objc private func buttonActionEditPassword() {
        self.delegate?.pressingButtonToOpenPasswordChangeWindow()
    }
}
