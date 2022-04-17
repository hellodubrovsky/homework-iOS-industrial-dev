//
//  LogInFactory.swift
//  Navigation
//
//  Created by Илья on 10.04.2022.
//

import Foundation


protocol LogInFactoryProtocol {
    func makeLogInInspecctor() -> LogInInspector
}



class LogInFactory: LogInFactoryProtocol {
    
    // MARK: - Public properties
    func makeLogInInspecctor() -> LogInInspector { LogInInspector() }
}
