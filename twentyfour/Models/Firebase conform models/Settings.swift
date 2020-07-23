//
//  Settings.swift
//  twentyfour
//
//  Created by Sebastian Fox on 17.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

//import Combine
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Settings: Codable {
//    let id: String?
    @DocumentID var id: String? = UUID().uuidString
    let uid: String?
    var isConditionsAccepted: Bool = false
    var showInfoTexts: Bool = true
    var currency: Currency = .euro
    var distanceUnit: DistanceUnit = .kilometres
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case isConditionsAccepted
        case showInfoTexts
        case currency
        case distanceUnit
    }
    
    init(uid: String) {
        id = UUID().uuidString
        isConditionsAccepted = false
        showInfoTexts = true
        currency = .euro
        distanceUnit = .kilometres
        self.uid = uid
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let isConditionsAccepted = data["isConditionsAccepted"] as? Bool else {
            return nil
        }
        
        guard let showInfoTexts = data["showInfoTexts"] as? Bool else {
            return nil
        }
        
        guard let uid = data["uid"] as? String else {
            return nil
        }
        
        guard let currency = data["currency"] as? Currency else {
            return nil
        }
        
        guard let distanceUnit = data["distanceUnit"] as? DistanceUnit else {
            return nil
        }
        
        id = document.documentID
        self.isConditionsAccepted = isConditionsAccepted
        self.showInfoTexts = showInfoTexts
        self.currency = currency
        self.distanceUnit = distanceUnit
        self.uid = uid
    }
}

enum Currency {
    case euro
    case dollar
}

extension Currency: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "euro":
            self = .euro
        case "dollar":
            self = .dollar
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .euro:
            try container.encode("euro", forKey: .rawValue)
        case .dollar:
            try container.encode("dollar", forKey: .rawValue)
        }
    }
}

enum DistanceUnit {
    case kilometres
    case miles
}

extension DistanceUnit: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "kilometres":
            self = .kilometres
        case "miles":
            self = .miles
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .kilometres:
            try container.encode("kilometres", forKey: .rawValue)
        case .miles:
            try container.encode("miles", forKey: .rawValue)
        }
    }
}

//extension Settings: DatabaseRepresentation {
//    
//    var representation: [String : Any] {
//        var rep = [
//            "uid": uid,
//            "isConditionsAccepted": isConditionsAccepted,
//            "showInfoTexts": showInfoTexts,
//            "currency": currency
////            ,
////            "distanceUnit": distanceUnit
//        ] as [String : Any]
//        
//        if let id = id {
//            rep["id"] = id
//        }
//        
//        return rep
//    }
//}
