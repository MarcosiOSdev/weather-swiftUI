//
//  CoordinatorProtocol.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI

protocol CoordinatorProtocol {
    associatedtype Start : View
    
    ///Start o coordinator
    func start() -> Self.Start
}
