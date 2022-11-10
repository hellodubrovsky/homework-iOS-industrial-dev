//
//  WeatherViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 09.11.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(testLabel)
        
        NSLayoutConstraint.activate([
        
            testLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        ])
    }
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        self.testLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
