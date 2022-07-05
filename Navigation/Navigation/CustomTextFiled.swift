//
//  CustomTextFiled.swift
//  Navigation
//
//  Created by Илья on 15.05.2022.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {
    
    init(text: String?, textPlaceholder: String, colorPlaceholder: UIColor, textColor: UIColor, radius: CGFloat?, borderWidth: CGFloat?, borderColor: UIColor) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.layer.cornerRadius = radius ?? 0
        self.layer.borderWidth = borderWidth ?? 0
        self.layer.borderColor = borderColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: textPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: colorPlaceholder])
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
