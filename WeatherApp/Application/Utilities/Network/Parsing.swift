//
//  Parsing.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import Combine

enum DecodeError: Error {
    case parsing(description: String)
}

func decode<Model: Decodable>(_ data: Data) -> AnyPublisher<Model, DecodeError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970
  
  return Just(data)
    .decode(type: Model.self, decoder: decoder)
    .mapError { error in
      DecodeError.parsing(description: error.localizedDescription)
  }.eraseToAnyPublisher()
}
