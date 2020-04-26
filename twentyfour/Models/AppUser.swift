//
//  AppUser.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AppUser: Hashable, Codable, Identifiable {
    var id: String
    var email: String
    var username: String
    var selected: Bool? = false
    var searchParameter: SearchParameter
    fileprivate var imageName: String
}

struct SearchParameter: Hashable, Codable {
    var isFoodSelected: Bool = false
    var isEntertainmentSelected: Bool = false
    var isSportSelected: Bool = false
    var isActive: Bool = false
    var description: String
    fileprivate var location: Coordinates
    var locationName: String
//    var time: Date

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude)
    }
    
    func activateSearch() {
        
    }
    
    func setSearchParameter() {
        
    }
    
    mutating func resetSearchParameter() {
//        self.isActive = false
//        self.isFoodSelected = false
//        self.isEntertainmentSelected = false
//        self.isSportSelected = false
//        self.description = ""
    }
}


extension AppUser {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}



struct AppUser_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
