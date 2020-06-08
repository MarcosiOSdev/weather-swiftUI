//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI

struct WeeklyWeatherView: View {
    
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    var coordinator: ApplicationCoordinatorDelegate
    
    var body: some View {
        NavigationView {
            List {
                searchField
                
                Section(header: Text("Results")) {
                    
                    if viewModel.dataSource.isEmpty {
                        emptyView
                    
                    } else {
                        currentWeatherView
                        weeklyForecastView
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Weather ⛅️")
        }
    }
}

private extension WeeklyWeatherView {
    var searchField: some View {        
        HStack(alignment: .center) {
            SearchBar(text: $viewModel.city)
        }
    }
    
    var emptyView: some View {
        Text("No results")
            .foregroundColor(.gray)
    }
    
    var currentWeatherView: some View {
        NavigationLink(destination: destinationCurrentView) {
            VStack(alignment: .leading) {
                Text(viewModel.city)
                Text("Weather Today")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    var destinationCurrentView: some View {
        coordinator.showCurrentWeather(with: viewModel.city)
    }
    
    var weeklyForecastView: some View {
        ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
    }
}

struct WeeklyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyWeatherView(viewModel: WeeklyWeatherViewModel(weatherNetwork: WeatherNetwork()), coordinator: CoordinatorMock())
    }
}
