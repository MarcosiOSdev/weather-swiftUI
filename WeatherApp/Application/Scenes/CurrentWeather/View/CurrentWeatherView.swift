//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @ObservedObject var viewModel: CurrentWeatherViewModel
    var coordinator: ApplicationCoordinatorDelegate
    
    var body: some View {
        List(content: content)
            .onAppear(perform: viewModel.refresh)
            .onDisappear(perform: coordinator.destroyCurrentWeather)
            .navigationBarTitle(viewModel.city)
    }
}

private extension CurrentWeatherView {
    func content() -> some View {
      if let viewModel = viewModel.dataSource {
        return AnyView(details(for: viewModel))
      } else {
        return AnyView(loading)
      }
    }
    func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
      CurrentWeatherRow(viewModel: viewModel)
    }
    
    var loading: some View {
      Text("Loading \(viewModel.city)'s weather...")
        .foregroundColor(.gray)
    }
}
