//
//  AccessToLocationViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 16.10.2022.
//

import UIKit

class AccessToLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = AccessToLocationView(delegate: self)
    }
}



// MARK: ViewDelegateProtocol

extension AccessToLocationViewController: AccessToLocationViewDelegate {
    func permissionButtonIsPressed() { print("Access done.") }
    func cancelButtonIsPressed() { print("Pressed cancel.") }
}
