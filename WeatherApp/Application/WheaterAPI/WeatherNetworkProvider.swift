//
//  WeatherNetworkProvider.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Combine

protocol WeatherNetworkProvider {
    func weeklyWheaterForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}
