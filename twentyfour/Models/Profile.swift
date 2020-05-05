//
//  Profil.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Profile: Hashable, Codable, Identifiable {
    var id: String
    var email: String
    var username: String
    var selected: Bool? = false
    var searchParameter: SearchParameter
    fileprivate var imageName: String
    var searchTypes: [EventType]
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


extension Profile {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}



struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

enum EventType: CaseIterable {
    case food, activity, sport
}

extension EventType: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .food
        case 1:
            self = .activity
        case 2:
            self = .sport
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .food:
            try container.encode(0, forKey: .rawValue)
        case .activity:
            try container.encode(1, forKey: .rawValue)
        case .sport:
            try container.encode(2, forKey: .rawValue)
        }
    }
    
}
