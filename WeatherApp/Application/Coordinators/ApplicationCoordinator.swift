//
//  ApplicationCoordinator.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI

protocol ApplicationCoordinatorDelegate {
    func showCurrentWeather(with city: String) -> AnyView
}

final class ApplicationCoordinator: Coordinator, CoordinatorProtocol {

    override init() {
        super.init()
    }
    
    func start() -> some View {
        startingWeeklyWeather()
    }
}

//MARK: - Starting WeeklyView
private extension ApplicationCoordinator {
    func startingWeeklyWeather() -> some View {
        WeeklyWeatherView(
            viewModel: WeeklyWeatherViewModel(
                weatherNetwork: self.networkProvider),
            coordinator: self)
    }
}

//MARK: - Starting CurrentView
private extension ApplicationCoordinator {
    func startingCurrentWeather(with city: String) -> some View {
        CurrentWeatherView(viewModel: CurrentWeatherViewModel(city: city, weatherNetwork: networkProvider))
    }
}

//MARK: - Dependency Inject
private extension ApplicationCoordinator {
    var networkProvider: WeatherNetworkProvider {
        return WeatherNetwork()
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorDelegate {
    func showCurrentWeather(with city: String) -> AnyView {
        AnyView(startingCurrentWeather(with: city))
    }
}

#if DEBUG

class CoordinatorMock: ApplicationCoordinatorDelegate {
    func showCurrentWeather(with city: String) -> AnyView {
        AnyView(CurrentWeatherView(viewModel: CurrentWeatherViewModel(city: "Mock City", weatherNetwork: WeatherNetwork())))
    }
}


#endif
