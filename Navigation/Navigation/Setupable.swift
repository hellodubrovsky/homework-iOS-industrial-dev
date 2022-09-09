//
//  Setupable.swift
//  Navigation
//
//  Created by Илья on 30.08.2022.
//

import Foundation

protocol ViewModelProtocol {}
protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
