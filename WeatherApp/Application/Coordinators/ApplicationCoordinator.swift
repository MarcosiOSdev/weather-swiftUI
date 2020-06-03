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
    func destroyCurrentWeather()
}


final class ApplicationCoordinator: Coordinator, CoordinatorProtocol {

    enum FlowScenes: CaseIterable {
        case weekly
        case current
    }
    
    var stacks = [FlowScenes]()
    
    override init() {
        super.init()
    }
    
    func start() -> some View {
        startingWeeklyWeather()
    }
}

//MARK: - Starting
private extension ApplicationCoordinator {
    func startingWeeklyWeather() -> some View {
        self.stacks.append(.weekly)
        return WeeklyWeatherView(
            viewModel: WeeklyWeatherViewModel(
                weatherNetwork: self.networkProvider),
            coordinator: self)
    }
    
    func startingCurrentWeather(with city: String) -> some View {
        self.stacks.append(.current)
        return CurrentWeatherView(
            viewModel: CurrentWeatherViewModel(
                city: city,
                weatherNetwork: networkProvider),
            coordinator: self)
    }
}

//MARK: - Dependency Inject
private extension ApplicationCoordinator {
    var networkProvider: WeatherNetworkProvider {
        return WeatherNetwork()
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorDelegate {
    func destroyCurrentWeather() {
        stacks.removeLast()
    }
    
    func showCurrentWeather(with city: String) -> AnyView {
        AnyView(startingCurrentWeather(with: city))
    }
}

#if DEBUG

class CoordinatorMock: ApplicationCoordinatorDelegate {
    func destroyCurrentWeather() {
        
    }
    
    func showCurrentWeather(with city: String) -> AnyView {
        AnyView(CurrentWeatherView(viewModel: CurrentWeatherViewModel(city: "Mock City", weatherNetwork: WeatherNetwork()), coordinator: self))
    }
}


#endif
