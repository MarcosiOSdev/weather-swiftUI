//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
