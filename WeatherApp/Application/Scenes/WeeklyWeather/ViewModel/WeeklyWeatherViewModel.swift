//
//  WeeklyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI
import Combine

final class WeeklyWeatherViewModel: ObservableObject, Identifiable {
    let weatherNetwork: WeatherNetworkProvider
    
    @Published var city: String = ""
    @Published var dataSource: [DailyWeatherRowViewModel] = []
    
    private var disposables = Set<AnyCancellable>()
    
    init(weatherNetwork: WeatherNetworkProvider) {
        self.weatherNetwork = weatherNetwork
        self.loading()
    }
    
    func loading() {
        let dispatcher = DispatchQueue(label: "WeatherViewModel")
        $city
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: dispatcher)
            .sink(receiveValue: fetchWeather(for:))
            .store(in: &disposables)
    }
    
    func fetchWeather(for city: String) {
        self.weatherNetwork
            .weeklyWheaterForecast(forCity: city)
            .map { response in
                response.list.map(DailyWeatherRowViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = []
                case .finished: break;
                }
            }) { [weak self] forecasts in
                guard let self = self else { return }
                self.dataSource = forecasts
            }
            .store(in: &disposables)
    }
    
}
