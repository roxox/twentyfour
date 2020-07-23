//
//  UserGroup.swift
//  twentyfour
//
//  Created by Sebastian Fox on 17.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import MapKit
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserGroup: Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    var title: String!
    var description: String!
    var location: CLLocationCoordinate2D!
    var locationPlacemark: String!
    var meetingpoint: CLLocationCoordinate2D?
    var meetingpointPlacemark: String?
    var meetingTime: Date?
    var datemode: Bool!
    var eventType: EventType!
    var memberscount: Int?
    
    // Anzeige von Usern in Gruppe: in anderer collection documenmt mit folgenden Werten: groupId, public user data (oder uid), user name, user photo, role, status
    // Anzeige von Gruppen: in anderer collection documenmt mit folgenden Werten: public user data (oder uid), groupId, title, user photo, role, status
    // #PREFERED# oder kombiniert: public user data (oder uid), user name, user photo, groupId, title, role, status
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case location
        case locationPlacemark
        case meetingpoint
        case meetingpointPlacemark
        case meetingTime
        case datemode
        case eventType
        case memberscount
    }
    
    init(title: String,
         description: String,
         location: CLLocationCoordinate2D,
         locationPlacemark: String,
         datemode: Bool,
         eventType: EventType,
         memberscount: Int
    ) {
        id = UUID().uuidString
        self.title = title
        self.description = description
        self.location = location
        self.locationPlacemark = locationPlacemark
//        self.meetingpoint = meetingpoint
//        self.meetingpointPlacemark = meetingpointPlacemark
//        self.meetingTime = meetingTime
        self.datemode = datemode
        self.eventType = eventType
        self.memberscount = memberscount
//        self.uid = uid
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let title = data["title"] as? String else {
            return nil
        }
        
        guard let description = data["description"] as? String else {
            return nil
        }
        
        guard let location = data["location"] as? CLLocationCoordinate2D else {
            return nil
        }
        
        guard let locationPlacemark = data["locationPlacemark"] as? String else {
            return nil
        }
        
        guard let meetingpoint = data["meetingpoint"] as? CLLocationCoordinate2D else {
            return nil
        }
        
        guard let meetingpointPlacemark = data["meetingpointPlacemark"] as? String else {
            return nil
        }
        
        guard let meetingTime = data["meetingTime"] as? Date else {
            return nil
        }
        
        guard let datemode = data["datemode"] as? Bool else {
            return nil
        }
        
        guard let eventType = data["eventType"] as? EventType else {
            return nil
        }
        
        guard let memberscount = data["memberscount"] as? Int else {
            return nil
        }
        
        id = document.documentID
        self.title = title
        self.description = description
        self.location = location
        self.locationPlacemark = locationPlacemark
        self.meetingpoint = meetingpoint
        self.meetingpointPlacemark = meetingpointPlacemark
        self.meetingTime = meetingTime
        self.datemode = datemode
        self.eventType = eventType
        self.memberscount = memberscount
    }
}

enum EventType {
    case food
    case leisure
    case sport
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
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "food":
            self = .food
        case "leisure":
            self = .leisure
        case "sport":
            self = .sport
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .food:
            try container.encode("food", forKey: .rawValue)
        case .leisure:
            try container.encode("leisure", forKey: .rawValue)
        case .sport:
            try container.encode("sport", forKey: .rawValue)
        }
    }
}
