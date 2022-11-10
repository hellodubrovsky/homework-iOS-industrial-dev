//
//  SettingsModel.swift
//  Weather
//
//  Created by Илья Дубровский on 07.11.2022.
//

import Foundation

struct SettingsModel: ViewModelProtocol {
    var temperatureIndex: Int
    var windIndex: Int
    var timeIndex: Int
    var notificationIndex: Int
}
