//
//  AccessToLocationView.swift
//  Weather
//
//  Created by Илья Дубровский on 16.10.2022.
//

import UIKit
import SnapKit


protocol AccessToLocationViewDelegate: AnyObject {
    func permissionButtonIsPressed()
    func cancelButtonIsPressed()
}



final class AccessToLocationView: UIView {
    
    // MARK: Private properties.
    
    private var delegate: AccessToLocationViewDelegate!
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnboardingImage-2.v2")
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .customWhite
        label.font = UIFont(name: "Rubik-SemiBold", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        var text = "Разрешить приложению Weather использовать данные \nо местоположении вашего устройства"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    private var firstDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    private var secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var text = "Вы можете изменить свой выбор в любое время из меню приложения"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    private var permissionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customOrange
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 12)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(permissionButtonIsPressed), for: .touchUpInside)
        return button
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customGray
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ САМ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 12)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancelButtonIsPressed), for: .touchUpInside)
        return button
    }()
   
    
    // MARK: Initialization

    init(delegate: AccessToLocationViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.settingUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setting UP View
    
    private func settingUpView() {
        self.backgroundColor = .customAccentBlueColor
        let allViews = [iconImageView, titleLabel, firstDescriptionLabel, secondDescriptionLabel, permissionButton, cancelButton]
        self.addSubviews(allViews)
        self.turningOffTheAutomaticMask(allViews)
        self.settingUpConstraints()
    }
    
    private func settingUpConstraints() {
        titleLabel.snp.makeConstraints { text in
            text.centerY.equalTo(self).offset(-15)
            text.leading.equalTo(self).offset(26)
            text.trailing.equalTo(self).offset(-26)
        }
        iconImageView.snp.makeConstraints { image in
            image.bottom.equalTo(self.titleLabel.snp.top).offset(-40)
            image.centerX.equalTo(self)
            image.width.equalTo(180)
            image.height.equalTo(196)
        }
        firstDescriptionLabel.snp.makeConstraints { text in
            text.top.equalTo(self.titleLabel.snp.bottom).offset(50)
            text.leading.equalTo(self).offset(30)
            text.trailing.equalTo(self).offset(-30)
        }
        secondDescriptionLabel.snp.makeConstraints { text in
            text.top.equalTo(self.firstDescriptionLabel.snp.bottom).offset(14)
            text.leading.equalTo(self).offset(30)
            text.trailing.equalTo(self).offset(-30)
        }
        permissionButton.snp.makeConstraints { button in
            button.top.equalTo(self.secondDescriptionLabel.snp.bottom).offset(44)
            button.leading.equalTo(self).offset(18)
            button.trailing.equalTo(self).offset(-18)
            button.height.equalTo(40)
        }
        cancelButton.snp.makeConstraints { button in
            button.top.equalTo(self.permissionButton.snp.bottom).offset(12)
            button.leading.equalTo(self).offset(18)
            button.trailing.equalTo(self).offset(-18)
            button.height.equalTo(40)
        }
    }
    
    
    // MARK: Private methods
    
    @objc private func permissionButtonIsPressed() {
        self.delegate.permissionButtonIsPressed()
    }
    
    @objc private func cancelButtonIsPressed() {
        self.delegate.cancelButtonIsPressed()
    }
}
