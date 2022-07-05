//
//  CustomButton.swift
//  Navigation
//
//  Created by Илья on 13.05.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    // MARK: - Private Properties
    private var buttonAction: () -> Void
    
    
    
    // MARK: - Init
    
    init(title: String, titleColor: UIColor, backgoundColor: UIColor, cornerRadius: CGFloat?, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgoundColor
        self.layer.cornerRadius = cornerRadius ?? 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    
    
    // MARK: - Private Methods
    
    @objc private func buttonTapped() {
        buttonAction()
    }
}
