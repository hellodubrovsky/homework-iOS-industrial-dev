//
//  WeatherViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 08.11.2022.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        title = "Москва, Россия"
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        settingsItem.tintColor = .customBlack
        
        let locationItem = UIBarButtonItem(image: UIImage(systemName: "mappin.circle"), style: .plain, target: self, action: nil)
        locationItem.tintColor = .customBlack
        
        self.navigationItem.rightBarButtonItem = locationItem
        self.navigationItem.leftBarButtonItem = settingsItem
    }
}
