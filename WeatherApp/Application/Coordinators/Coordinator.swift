//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 02/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI

/// Coordinator from APP
open class Coordinator {
  
  weak var parent: Coordinator?
  private(set) var children: Set<Coordinator>
  
  init() {
    children = Set()
  }

  //MARK: - Default Functions in Coordinators
  final func addChild(_ coordinator: Coordinator) {
      coordinator.parent = self
      children.insert(coordinator)
  }
  
  final func removeChild(_ coordinator: Coordinator) {
      children.remove(coordinator)
  }
  
  final func removeAllChildren() {
      children.removeAll()
  }
}


//MARK: - Hashable and Equatable to Identifier and Set
extension Coordinator: Hashable {
  public func hash(into hasher: inout Hasher) {
      hasher.combine(ObjectIdentifier(self).hashValue)
  }
}

extension Coordinator: Equatable {
  public static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
     ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
  }
}
