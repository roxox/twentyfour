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

struct Search: Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    let pubid: String?
    let startDate: Date?
    var expireDate: Date?
    var location: CLLocationCoordinate2D?
    var isFoodSelected: Bool?
    var isLeisureSelected: Bool?
    var isSportSelected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case pubid
        case startDate
        case expireDate
        case location
        case isFoodSelected
        case isLeisureSelected
        case isSportSelected
    }
    
    init(_ pubid: String, _ startDate: Date, _ expireDate: Date, _ location: CLLocationCoordinate2D, _ isFoodSelected: Bool, _ isLeisureSelected: Bool, _ isSportSelected: Bool
    ) {
        id = UUID().uuidString
        self.startDate = startDate
        self.expireDate = expireDate
        self.location = location
        self.isFoodSelected = isFoodSelected
        self.isLeisureSelected = isLeisureSelected
        self.isSportSelected = isSportSelected
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
        
        guard let isFoodSelected = data["isFoodSelected"] as? Bool else {
            return nil
        }
        
        guard let isLeisureSelected = data["isLeisureSelected"] as? Bool else {
            return nil
        }
        
        guard let isSportSelected = data["isSportSelected"] as? Bool else {
            return nil
        }
        
        guard let pubid = data["pubid"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.startDate = startDate
        self.expireDate = expireDate
        self.location = location
        self.isFoodSelected = isFoodSelected
        self.isLeisureSelected = isLeisureSelected
        self.isSportSelected = isSportSelected
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
