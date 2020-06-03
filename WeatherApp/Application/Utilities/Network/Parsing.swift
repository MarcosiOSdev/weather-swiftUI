//
//  Parsing.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, WeatherError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970
  
  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      WeatherError.parsing(description: error.localizedDescription)
  }.eraseToAnyPublisher()
}
