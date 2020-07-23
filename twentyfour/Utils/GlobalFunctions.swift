//
//  HelperFunctions.swift
//  twentyfour
//
//  Created by Sebastian Fox on 05.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit


func makeGradient(colors: [Color]) -> some View {
    LinearGradient(
        gradient: .init(colors: colors),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}



let locationManager = CLLocationManager()

func globalLookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                -> Void ) {
    // Use the last reported location.
//            if let lastLocation = locationManager.location {
    if let lastLocation = locationManager.location {
        let geocoder = CLGeocoder()
            
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(lastLocation,
                    completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
             // An error occurred during geocoding.
                completionHandler(nil)
            }
        })
    }
    else {
        // No location was available.
        completionHandler(nil)
    }
}
