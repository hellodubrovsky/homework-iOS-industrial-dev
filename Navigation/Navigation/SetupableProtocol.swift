//
//  SetupableProtocol.swift
//  Navigation
//
//  Created by Илья Дубровский on 13.09.2022.
//

import Foundation

protocol ViewModelProtocol {}
protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
