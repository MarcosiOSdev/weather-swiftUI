//
//  CurrentWeatherRowViewModel.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 03/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct CurrentWeatherRowViewModel {
  private let item: CurrentWeatherForecastResponse
  
  var temperature: String {
    return String(format: "%.1f", item.main.temperature)
  }
  
  var maxTemperature: String {
    return String(format: "%.1f", item.main.maxTemperature)
  }
  
  var minTemperature: String {
    return String(format: "%.1f", item.main.minTemperature)
  }
  
  var humidity: String {
    return String(format: "%.1f", item.main.humidity)
  }
  
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D.init(latitude: item.coord.lat, longitude: item.coord.lon)
  }
  
  init(item: CurrentWeatherForecastResponse) {
    self.item = item
  }
}
