//
//  TestMainController.swift
//  Weather
//
//  Created by Илья Дубровский on 19.10.2022.
//

import Foundation
import UIKit

class TestMainController: UIViewController {
    
    private var locationManager = AppLocationManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if locationManager.checkingForAccess() {
            self.view.backgroundColor = .blue
        } else {
            self.view.backgroundColor = .red
        }
    }
}
