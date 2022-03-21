//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Илья on 14.12.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(userName)
        self.addSubview(userDescription)
        self.addSubview(buttonShowStatus)
        self.addSubview(statusTextField)
        self.addSubview(viewBackground)
        self.addSubview(cancelButton)
        self.addSubview(userImage)
        addingLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Constants for avatar and it's background
    
    enum ConstraintsForAvatarAndItsBackground {
        
        // Avatar
        static var topSmallImage: NSLayoutConstraint?
        static var leadingSmallImage: NSLayoutConstraint?
        static var widthSmallImage: NSLayoutConstraint?
        static var heightSmallImage: NSLayoutConstraint?
        
        static var centerXBigImage: NSLayoutConstraint?
        static var centerYBigImage: NSLayoutConstraint?
        static var widthBigImage: NSLayoutConstraint?
        static var heightBigImage: NSLayoutConstraint?
        
        
        // Background avatar
        static var centerXSmallBackgroundView: NSLayoutConstraint?
        static var centerYSmallBackgroundView: NSLayoutConstraint?
        static var widthSmallBackgroundView: NSLayoutConstraint?
        static var heightSmallBackgroundView: NSLayoutConstraint?
        
        static var centerXBigBackgroundView: NSLayoutConstraint?
        static var centerYBigBackgroundView: NSLayoutConstraint?
        static var widthBigBackgroundView: NSLayoutConstraint?
        static var heightBigBackgroundView: NSLayoutConstraint?
    }
    


    // MARK: Private object's
    
    private let userName: UILabel = {
        let name = UILabel()
        name.text = "@ALIEN"
        name.font = .boldSystemFont(ofSize: 20)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let userDescription: UILabel = {
        let description = UILabel()
        description.text = "Waiting for something ..."
        description.font = .systemFont(ofSize: 14, weight: .regular)
        description.textColor = .white
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    internal lazy var userImage: UIView = {
        let image = UIView()
        image.layer.contents = UIImage(named: "alienHipster")?.cgImage
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
    
    internal let viewBackground: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonShowStatus: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemBlue
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor(ciColor: .black).cgColor
        button.addTarget(self, action: #selector(buttonShowStatusPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    
    // MARK: Private method's
    
    // Действие, по нажатию на маленький аватар
    @objc func actionByClickingOnAvatar() {
        settingUpConstraintsForSmallImage()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
            self.userImage.layer.borderWidth = 0
            self.userImage.layer.cornerRadius = 0
        }, completion: { _ in self.cancelButton.isHidden = false })
    }
    
    // Действие, по нажатию на расширенный аватар
    @objc func backButtonAction() {
        settingUpConstraintsForLargeImage()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
            self.userImage.layer.borderWidth = 3
            self.userImage.layer.cornerRadius = 50
            self.cancelButton.isHidden = true
        }, completion: nil)
    }
    
    @objc private func buttonShowStatusPressed() {
        guard statusText != "" else { return }
        userDescription.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    private func settingUpConstraintsForSmallImage() {
        
        // Avatar (выключаем констрейнты маленького аватара, и включаем констренты большого)
        ConstraintsForAvatarAndItsBackground.topSmallImage?.isActive = false
        ConstraintsForAvatarAndItsBackground.leadingSmallImage?.isActive = false
        ConstraintsForAvatarAndItsBackground.widthSmallImage?.isActive = false
        ConstraintsForAvatarAndItsBackground.heightSmallImage?.isActive = false
        
        ConstraintsForAvatarAndItsBackground.centerXBigImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.centerYBigImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.widthBigImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.heightBigImage?.isActive = true
        
        // Background avatar (выключаем констрейнты маленькой view, и включаем констренты для полноэкранной)
        ConstraintsForAvatarAndItsBackground.centerXSmallBackgroundView?.isActive = false
        ConstraintsForAvatarAndItsBackground.centerYSmallBackgroundView?.isActive = false
        ConstraintsForAvatarAndItsBackground.widthSmallBackgroundView?.isActive = false
        ConstraintsForAvatarAndItsBackground.heightSmallBackgroundView?.isActive = false
        
        ConstraintsForAvatarAndItsBackground.centerXBigBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.centerYBigBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.widthBigBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.heightBigBackgroundView?.isActive = true
    }
    
    private func settingUpConstraintsForLargeImage() {
        
        // Avatar
        ConstraintsForAvatarAndItsBackground.centerXBigImage?.isActive = false
        ConstraintsForAvatarAndItsBackground.centerYBigImage?.isActive = false
        ConstraintsForAvatarAndItsBackground.widthBigImage?.isActive = false
        ConstraintsForAvatarAndItsBackground.heightBigImage?.isActive = false
        
        ConstraintsForAvatarAndItsBackground.topSmallImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.leadingSmallImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.widthSmallImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.heightSmallImage?.isActive = true
        
        // Background avatar
        ConstraintsForAvatarAndItsBackground.centerXBigBackgroundView?.isActive = false
        ConstraintsForAvatarAndItsBackground.centerYBigBackgroundView?.isActive = false
        ConstraintsForAvatarAndItsBackground.widthBigBackgroundView?.isActive = false
        ConstraintsForAvatarAndItsBackground.heightBigBackgroundView?.isActive = false
        
        ConstraintsForAvatarAndItsBackground.centerXSmallBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.centerYSmallBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.widthSmallBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.heightSmallBackgroundView?.isActive = true
    }
    
    private func addingLayoutConstraints() {
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            userName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            userDescription.topAnchor.constraint(equalTo: userName.topAnchor, constant: 50),
            userDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 132),
            userDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            buttonShowStatus.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            buttonShowStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonShowStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -16),
            buttonShowStatus.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.topAnchor.constraint(equalTo: userDescription.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 130),
            statusTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Avatar close button (устанавливаем констрейнты для кнопки закрытия увеличенного аватара)
        cancelButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16.0).isActive = true
        cancelButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        
        // Avatar (устанавливаем констрейнты для маленького аватара)
        ConstraintsForAvatarAndItsBackground.topSmallImage = userImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16.0)
        ConstraintsForAvatarAndItsBackground.leadingSmallImage = userImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ConstraintsForAvatarAndItsBackground.widthSmallImage = userImage.widthAnchor.constraint(equalToConstant: 100)
        ConstraintsForAvatarAndItsBackground.heightSmallImage = userImage.heightAnchor.constraint(equalToConstant: 100)
        
        ConstraintsForAvatarAndItsBackground.topSmallImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.leadingSmallImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.widthSmallImage?.isActive = true
        ConstraintsForAvatarAndItsBackground.heightSmallImage?.isActive = true
        
        
        // Background avatar (устанавливаем констрейнты для view под маленьким аватаром)
        ConstraintsForAvatarAndItsBackground.centerXSmallBackgroundView = viewBackground.centerXAnchor.constraint(equalTo: userImage.centerXAnchor)
        ConstraintsForAvatarAndItsBackground.centerYSmallBackgroundView = viewBackground.centerYAnchor.constraint(equalTo: userImage.centerYAnchor)
        ConstraintsForAvatarAndItsBackground.widthSmallBackgroundView = viewBackground.widthAnchor.constraint(equalToConstant: 0)
        ConstraintsForAvatarAndItsBackground.heightSmallBackgroundView = viewBackground.heightAnchor.constraint(equalToConstant: 0)
        
        ConstraintsForAvatarAndItsBackground.centerXSmallBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.centerYSmallBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.widthSmallBackgroundView?.isActive = true
        ConstraintsForAvatarAndItsBackground.heightSmallBackgroundView?.isActive = true
    }
}
