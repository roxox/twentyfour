//
//  Search.swift
//  twentyfour
//
//  Created by Sebastian Fox on 17.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Search: Hashable, Codable, Identifiable {
    
    static func == (lhs: Search, rhs: Search) -> Bool {
        lhs.pubid == rhs.pubid
    }
    
    var id: String? = UUID().uuidString
    let pubid: String?
    let startDate: Date?
    var expireDate: Date?
    var location: CLLocationCoordinate2D?
    var locationName: String?
    var isFoodSelected: Bool?
    var isLeisureSelected: Bool?
    var isSportSelected: Bool?
    var maxDistance: Double?
    var hashValue: Int {
         return id.hashValue
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case pubid
        case startDate
        case expireDate
        case location
        case locationName
        case isFoodSelected
        case isLeisureSelected
        case isSportSelected
        case maxDistance
    }
    
    init(_ pubid: String, _ startDate: Date, _ expireDate: Date, _ location: CLLocationCoordinate2D, _ locationName: String, _ isFoodSelected: Bool, _ isLeisureSelected: Bool, _ isSportSelected: Bool, _ maxDistance: Double
    ) {
        id = UUID().uuidString
        self.startDate = startDate
        self.expireDate = expireDate
        self.location = location
        self.locationName = locationName
        self.isFoodSelected = isFoodSelected
        self.isLeisureSelected = isLeisureSelected
        self.isSportSelected = isSportSelected
        self.maxDistance = maxDistance
        self.pubid = pubid
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let startDate = data["startDate"] as? Date else {
            return nil
        }
        
        guard let expireDate = data["expireDate"] as? Date else {
            return nil
        }
        
        guard let location = data["location"] as? CLLocationCoordinate2D else {
            return nil
        }
        
        guard let locationName = data["locationName"] as? String else {
            return nil
        }
        
        guard let isFoodSelected = data["isFoodSelected"] as? Bool else {
            return nil
        }
        
        guard let isLeisureSelected = data["isLeisureSelected"] as? Bool else {
            return nil
        }
        
        guard let isSportSelected = data["isSportSelected"] as? Bool else {
            return nil
        }
        
        guard let maxDistance = data["maxDistance"] as? Double else {
            return nil
        }
        
        guard let pubid = data["pubid"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.startDate = startDate
        self.expireDate = expireDate
        self.location = location
        self.locationName = locationName
        self.isFoodSelected = isFoodSelected
        self.isLeisureSelected = isLeisureSelected
        self.isSportSelected = isSportSelected
        self.maxDistance = maxDistance
        self.pubid = pubid
    }
    
}

extension CLLocationCoordinate2D: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(longitude)
        try container.encode(latitude)
    }
     
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let longitude = try container.decode(CLLocationDegrees.self)
        let latitude = try container.decode(CLLocationDegrees.self)
        self.init(latitude: latitude, longitude: longitude)
    }
}

//extension Search: DatabaseRepresentation {
//
//    var representation: [String : Any] {
//        var rep = [
//            "uid": uid as Any,
//            "startDate": startDate!,
//            "expireDate": expireDate!,
////            "locationLongitude": locationLongitude!,
////            "locationLangitude": locationLangitude!
//        ] as [String : Any]
//
//        if let id = id {
//            rep["id"] = id
//        }
//
//        return rep
//    }
//}
