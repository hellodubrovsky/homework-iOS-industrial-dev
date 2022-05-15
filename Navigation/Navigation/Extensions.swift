//
//  Extensions.swift
//  Navigation
//
//  Created by Илья on 15.05.2022.
//

import Foundation
import UIKit



// MARK: - View

extension UIView {
    
    // Возможность добавления нескольких subview сразу.
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    // Возможность добавления в Stack нескольких subview сразу.
    func addArrangedSubviews(stack: UIStackView, views: [UIView]) {
        views.forEach { stack.addArrangedSubview($0) }
    }
}
