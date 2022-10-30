//
//  Extension+UIView.swift
//  Weather
//
//  Created by Илья Дубровский on 16.10.2022.
//

import UIKit

extension UIView {
    
    /// Добавление на view всех элементов сразу.
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    /// Отключение автоматический расстановки констрейнтов у всех элементов сразу.
    func turningOffTheAutomaticMask(_ views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
