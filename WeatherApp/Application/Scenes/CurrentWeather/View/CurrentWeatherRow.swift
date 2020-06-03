//
//  CurrentWeatherRow.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 03/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI
import MapKit

struct CurrentWeatherRow: View {
  private let viewModel: CurrentWeatherRowViewModel
  
  init(viewModel: CurrentWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      MapView(coordinate: viewModel.coordinate)
        .cornerRadius(25)
        .frame(height: 300)
        .disabled(true)
      
      VStack(alignment: .leading) {
        HStack {
          Text("☀️ Temperature:")
          Text("\(viewModel.temperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("📈 Max temperature:")
          Text("\(viewModel.maxTemperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("📉 Min temperature:")
          Text("\(viewModel.minTemperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("💧 Humidity:")
          Text(viewModel.humidity)
            .foregroundColor(.gray)
        }
      }
    }
  }
}
