//
//  StorableProtocol.swift
//  Navigation
//
//  Created by Илья on 23.08.2022.
//

import Foundation
import RealmSwift

protocol Storable {}

extension Object: Storable {}
