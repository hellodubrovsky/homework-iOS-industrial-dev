//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Илья on 14.12.2021.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UIView {
    
    // MARK: Constants for avatar and it's background
    
    enum ConstraintsForAvatarAndItsBackground {
        static var center: CGPoint?
        static var width: CGFloat?
        static var heightBackground: CGFloat?
    }
    
    
    
    // MARK: - Public initializer
    
    init(name: String, status: String?, image: UIImage?) {
        super.init(frame: .zero)
        self.name = name
        self.status = status
        self.image = image
        settingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    // MARK: - Private properties
    
    private var name: String!
    private var status: String?
    private var image: UIImage?
    
    private lazy var userName: UILabel = {
        let name = UILabel()
        name.text = self.name
        name.font = .boldSystemFont(ofSize: 20)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var userDescription: UILabel = {
        let description = UILabel()
        description.text = self.status ?? "Waiting for something ..."
        description.font = .systemFont(ofSize: 14, weight: .regular)
        description.textColor = .white
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var userImage: UIView = {
        let image = UIView()
        image.layer.contents = self.image?.cgImage ?? UIImage(named: "cat")?.cgImage
        image.layer.contentsGravity = .resizeAspect
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 3
        image.backgroundColor = .white
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionByClickingOnAvatar)))
        return image
    }()
    
    private let cancelButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let viewBackground: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonShowStatus: UIButton = {
        let button = CustomButton(title: "Set status", titleColor: .white, backgoundColor: .systemBlue, cornerRadius: 16) { self.buttonShowStatusPressed() }
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor(ciColor: .black).cgColor
        return button
    }()
    
    private let statusTextField: UITextField = {
        let status = UITextField()
        status.attributedPlaceholder =  NSAttributedString(string: "Set your status..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        status.backgroundColor = .white
        status.font = .systemFont(ofSize: 15, weight: .regular)
        status.textColor = .black
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor(ciColor: .black).cgColor
        status.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        status.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        status.leftViewMode = .always
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private var statusText: String = ""
    
    
    
    // MARK: - Private methods
    
    // Действие, по нажатию на маленький аватар
    @objc private func actionByClickingOnAvatar() {
        self.userImage.snp.removeConstraints()
        self.userImage.snp.updateConstraints { make in
            make.center.equalTo(ConstraintsForAvatarAndItsBackground.center!)
            make.width.height.equalTo(ConstraintsForAvatarAndItsBackground.width!)
        }
        
        self.viewBackground.snp.removeConstraints()
        self.viewBackground.snp.updateConstraints { make in
            make.center.equalTo(ConstraintsForAvatarAndItsBackground.center!)
            make.width.equalTo(ConstraintsForAvatarAndItsBackground.width!)
            make.height.equalTo(ConstraintsForAvatarAndItsBackground.heightBackground!)
        }
    
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
            self.userImage.layer.borderWidth = 0
            self.userImage.layer.cornerRadius = 0
        }, completion: { _ in self.cancelButton.isHidden = false })
    }
    
    // Действие, по нажатию на расширенный аватар
    @objc private func backButtonAction() {
        userImage.snp.removeConstraints()
        viewBackground.snp.removeConstraints()
        settingView()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
            self.userImage.layer.borderWidth = 3
            self.userImage.layer.cornerRadius = 50
            self.cancelButton.isHidden = true
        }, completion: { _ in self.cancelButton.isHidden = true })
    }
    
    // Обработка нажатия на кнопку отображение статуса
    private func buttonShowStatusPressed() {
        guard statusText != "" else { return }
        userDescription.text = statusText
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка View
    private func settingView() {
        self.addSubview(userName)
        self.addSubview(userDescription)
        self.addSubview(buttonShowStatus)
        self.addSubview(statusTextField)
        self.addSubview(viewBackground)
        self.addSubview(cancelButton)
        self.addSubview(userImage)
        installingConstraints()
    }
    
    // Настройка констрейнтов
    private func installingConstraints() {
        self.userName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(27)
            make.centerX.equalToSuperview()
        }
        
        self.userDescription.snp.makeConstraints { make in
            make.top.equalTo(userName).inset(50)
            make.left.equalTo(safeAreaLayoutGuide).inset(132)
            make.right.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        self.statusTextField.snp.makeConstraints { make in
            make.top.equalTo(userDescription.snp.bottom).offset(8)
            make.left.equalTo(safeAreaLayoutGuide).inset(130)
            make.right.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
        }
        
        self.buttonShowStatus.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.left.right.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        self.userImage.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(100)
        }
        
        self.viewBackground.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(userImage)
            make.width.height.equalTo(0)
        }
        
        self.cancelButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
