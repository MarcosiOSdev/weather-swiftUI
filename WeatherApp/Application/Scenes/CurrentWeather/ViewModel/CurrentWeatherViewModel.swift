//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Combine
import Foundation

final class CurrentWeatherViewModel: ObservableObject, Identifiable {
    
    let city: String
    private let weatherNetwork: WeatherNetworkProvider
    
    @Published var dataSource: CurrentWeatherRowViewModel?
    private var disposabled = Set<AnyCancellable>()
    
    init(city: String, weatherNetwork: WeatherNetworkProvider) {
        self.weatherNetwork = weatherNetwork
        self.city = city
    }
    
    func refresh() {
        weatherNetwork
            .currentWeatherForecast(forCity: city)
            .map(CurrentWeatherRowViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                
                switch value {
                case .failure:
                    self.dataSource = nil
                case .finished: break;
                }
            }) { viewModel in
                self.dataSource = viewModel
            }
            .store(in: &disposabled)
    }
}
