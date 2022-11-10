//
//  SetupableProtocol.swift
//  Weather
//
//  Created by Илья Дубровский on 07.11.2022.
//

import Foundation

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
