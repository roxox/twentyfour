//
//  LocationManager.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  private let geocoder = CLGeocoder()
  
    private let locationManager = CLLocationManager()
      let objectWillChange = PassthroughSubject<Void, Never>()

      @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
      }

      @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
      }

      override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
      }

  @Published var placemark: CLPlacemark? {
    willSet { objectWillChange.send() }
  }

  private func geocode() {
    guard let location = self.location else { return }
    geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
      if error == nil {
        self.placemark = places?[0]
      } else {
        self.placemark = nil
      }
    })
  }
}
