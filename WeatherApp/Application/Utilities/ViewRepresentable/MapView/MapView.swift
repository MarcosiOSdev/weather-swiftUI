//
//  MapView.swift
//  WeatherApp
//
//  Created by Marcos Felipe Souza on 03/06/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  private let coordinate: CLLocationCoordinate2D
  
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView()
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    view.addAnnotation(annotation)
    
    view.setRegion(region, animated: true)
  }
}
