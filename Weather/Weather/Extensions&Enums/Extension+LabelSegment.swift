//
//  Extension+LabelSegment.swift
//  Weather
//
//  Created by Илья Дубровский on 07.11.2022.
//

import UIKit
import Foundation
import BetterSegmentedControl

extension LabelSegment {
    static var temperatureInC = LabelSegment(text: "C", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var temperatureInF = LabelSegment(text: "F", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var windInKm = LabelSegment(text: "Km", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var windInMi = LabelSegment(text: "Mi", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var time12 = LabelSegment(text: "12", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var time24 = LabelSegment(text: "24", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var notificationOn = LabelSegment(text: "On", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
    static var notificationOff = LabelSegment(text: "Off", normalFont: UIFont(name: "Rubik-Regular", size: 16), selectedFont: UIFont(name: "Rubik-Regular", size: 16), selectedTextColor: .customWhite)
}
