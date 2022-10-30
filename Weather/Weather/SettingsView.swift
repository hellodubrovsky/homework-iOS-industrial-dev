//
//  SettingsView.swift
//  Weather
//
//  Created by Илья Дубровский on 30.10.2022.
//

import UIKit
import SnapKit
import BetterSegmentedControl

class SettingsView: UIView {
    
    
    // MARK: Private UI properties
    
    private var firstCloudImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloud-1")
        return imageView
    }()
    
    private var secondCloudImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloud-2")
        return imageView
    }()
    
    private var thirdCloudImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloud-3")
        return imageView
    }()
    
    private var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        view.layer.backgroundColor = UIColor.customWhite.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        var text = "Настройки"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.7
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private var subtitleTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextGray
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        var text = "Температура"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private var subtitleWindLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextGray
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        var text = "Скорость ветра"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private var subtitleTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextGray
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        var text = "Формат времени"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private var subtitleNotificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTextGray
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        var text = "Уведомления"
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private var setupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customOrange
        button.layer.cornerRadius = 10
        button.setTitle("Установить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.titleLabel?.textColor = .customWhite
        return button
    }()
    
    private var temperatureSwitch: BetterSegmentedControl = {
        let customSwitch = BetterSegmentedControl()
        customSwitch.backgroundColor = .customSwitchWhiteColor
        customSwitch.indicatorViewBackgroundColor = .customSwitchBlueColor
        customSwitch.cornerRadius = 5
        customSwitch.segments = [LabelSegment(text: "C", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite),
                                 LabelSegment(text: "F", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)]
        return customSwitch
    }()
    
    private lazy var windSwitch: BetterSegmentedControl = {
        let customSwitch = BetterSegmentedControl()
        customSwitch.backgroundColor = .customSwitchWhiteColor
        customSwitch.indicatorViewBackgroundColor = .customSwitchBlueColor
        customSwitch.cornerRadius = 5
        customSwitch.segments = [LabelSegment(text: "Km", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite),
                                 LabelSegment(text: "Mi", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)]
        return customSwitch
    }()
    
    private lazy var timeSwitch: BetterSegmentedControl = {
        let customSwitch = BetterSegmentedControl()
        customSwitch.backgroundColor = .customSwitchWhiteColor
        customSwitch.indicatorViewBackgroundColor = .customSwitchBlueColor
        customSwitch.cornerRadius = 5
        customSwitch.segments = [LabelSegment(text: "12", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite),
                                 LabelSegment(text: "24", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)]
        return customSwitch
    }()
    
    private lazy var notificationSwitch: BetterSegmentedControl = {
        let customSwitch = BetterSegmentedControl()
        customSwitch.backgroundColor = .customSwitchWhiteColor
        customSwitch.indicatorViewBackgroundColor = .customSwitchBlueColor
        customSwitch.cornerRadius = 5
        customSwitch.segments = [LabelSegment(text: "On", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite),
                                 LabelSegment(text: "Off", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)]
        return customSwitch
    }()
    
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Setup View
    
    private func setupView() {
        self.backgroundColor = .customAccentBlueColor
        let views = [overlayView, firstCloudImage, secondCloudImage, thirdCloudImage]
        let subviews = [titleLabel, subtitleTemperatureLabel, subtitleWindLabel, subtitleTimeLabel, subtitleNotificationLabel, setupButton, temperatureSwitch, windSwitch, timeSwitch, notificationSwitch]
        self.addSubviews(views)
        self.overlayView.addSubviews(subviews)
        self.turningOffTheAutomaticMask(views + subviews)
        settingUpConstraints()
    }
    
    
    
    // MARK: Layout
    // TODO: Нужен кастомный размер для iPad
    
    private func settingUpConstraints() {
        self.overlayView.snp.makeConstraints { view in
            view.center.equalTo(self)
            view.leading.equalTo(self).offset(28)
            view.trailing.equalTo(self).offset(-28)
            view.height.equalTo(330)
        }
        
        self.firstCloudImage.snp.makeConstraints { image in
            image.bottom.equalTo(overlayView.snp.top).offset(-145)
            image.leading.equalTo(self)
        }
        
        self.secondCloudImage.snp.makeConstraints { image in
            image.bottom.equalTo(overlayView.snp.top).offset(-25)
            image.trailing.equalTo(self)
        }
        
        self.thirdCloudImage.snp.makeConstraints { image in
            image.top.equalTo(overlayView.snp.bottom).offset(60)
            image.centerX.equalTo(self)
        }
        
        self.titleLabel.snp.makeConstraints { label in
            label.top.equalTo(self.overlayView).offset(26)
            label.leading.equalTo(self.overlayView).offset(20)
            label.height.equalTo(20)
        }
        
        self.subtitleTemperatureLabel.snp.makeConstraints { label in
            label.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            label.leading.equalTo(self.overlayView).offset(20)
        }
        
        self.subtitleWindLabel.snp.makeConstraints { label in
            label.top.equalTo(self.subtitleTemperatureLabel.snp.bottom).offset(20)
            label.leading.equalTo(self.overlayView).offset(20)
        }
        
        self.subtitleTimeLabel.snp.makeConstraints { label in
            label.top.equalTo(self.subtitleWindLabel.snp.bottom).offset(20)
            label.leading.equalTo(self.overlayView).offset(20)
        }
        
        self.subtitleNotificationLabel.snp.makeConstraints { label in
            label.top.equalTo(self.subtitleTimeLabel.snp.bottom).offset(20)
            label.leading.equalTo(self.overlayView).offset(20)
        }
        
        self.setupButton.snp.makeConstraints { button in
            button.bottom.equalTo(self.overlayView).offset(-16)
            button.leading.equalTo(self.overlayView).offset(35)
            button.trailing.equalTo(self.overlayView).offset(-35)
            button.height.equalTo(40)
        }
        
        self.temperatureSwitch.snp.makeConstraints { customSwitch in
            customSwitch.trailing.equalTo(self.overlayView).offset(-30)
            customSwitch.centerY.equalTo(self.subtitleTemperatureLabel)
            customSwitch.height.equalTo(30)
            customSwitch.width.equalTo(80)
        }
        
        self.windSwitch.snp.makeConstraints { customSwitch in
            customSwitch.trailing.equalTo(self.overlayView).offset(-30)
            customSwitch.centerY.equalTo(self.subtitleWindLabel)
            customSwitch.height.equalTo(30)
            customSwitch.width.equalTo(80)
        }
        
        self.timeSwitch.snp.makeConstraints { customSwitch in
            customSwitch.trailing.equalTo(self.overlayView).offset(-30)
            customSwitch.centerY.equalTo(self.subtitleTimeLabel)
            customSwitch.height.equalTo(30)
            customSwitch.width.equalTo(80)
        }
        
        self.notificationSwitch.snp.makeConstraints { customSwitch in
            customSwitch.trailing.equalTo(self.overlayView).offset(-30)
            customSwitch.centerY.equalTo(self.subtitleNotificationLabel)
            customSwitch.height.equalTo(30)
            customSwitch.width.equalTo(80)
        }
    }
}
