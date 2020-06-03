//
//  WeatherNetwork.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import Combine

class WeatherNetwork {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}


//MARK: - Fetches
extension WeatherNetwork: WeatherNetworkProvider {
    func weeklyWheaterForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        let urlComponents = weeklyForecastComponent(with: city)
        
        guard let url = urlComponents.url else {
            let error = WeatherError.network(description: "Could't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                WeatherError.network(description: error.localizedDescription)
        }.flatMap(maxPublishers: .max(1)) { pairs in            
            Just(pairs.data)
                .decode(type: WeeklyForecastResponse.self, decoder: JSONDecoder())
                .mapError { error in
                    WeatherError.parsing(description: error.localizedDescription)
                }
        }.eraseToAnyPublisher()
    }
    
    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
        let urlComponents = currentDailyForecastComponent(with: city)
        return fetching(with: urlComponents)
//        guard let url = urlComponents.url else {
//            return Fail(error: WeatherError.network(description: "Could't create URL"))
//                .eraseToAnyPublisher()
//        }
//        
//        return session.dataTaskPublisher(for: URLRequest(url: url))
//            .mapError { error in
//                WeatherError.network(description: error.localizedDescription)
//            }
//            .flatMap(maxPublishers: .max(1)) { pairs in
//                Just(pairs.data)
//                    .decode(type: CurrentWeatherForecastResponse.self, decoder: JSONDecoder())
//                    .mapError { error in
//                        WeatherError.parsing(description: error.localizedDescription)
//                    }
//            }
//            .eraseToAnyPublisher()            
    }
}




//MARK: - Builder Components
extension WeatherNetwork {
    private func defaultForecastComponents(with city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        return components
    }
    
    private func weeklyForecastComponent(with city: String) -> URLComponents {
        var components = defaultForecastComponents(with: city)
        components.path = OpenWeatherAPI.path + "/forecast"
        return components
    }
    private func currentDailyForecastComponent(with city: String) -> URLComponents {
        var components = defaultForecastComponents(with: city)
        components.path = OpenWeatherAPI.path + "/weather"
        return components
    }
}


//MARK: - Information Path Network
extension WeatherNetwork {
    struct OpenWeatherAPI {
      static let scheme = "https"
      static let host = "api.openweathermap.org"
      static let path = "/data/2.5"
      static let key = "954c377106e45254ceabcb2930407b62"
    }
}

extension WeatherNetwork {
    private func fetching<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
      guard let url = components.url else {
        let error = WeatherError.network(description: "Could't create URL")
        return Fail(error: error).eraseToAnyPublisher()
      }
      
      return session.dataTaskPublisher(for: URLRequest(url: url))
        .mapError { error in
          WeatherError.network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
          decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
}
