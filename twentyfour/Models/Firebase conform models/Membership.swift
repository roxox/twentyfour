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

struct Membership: Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    var title: String?
    var location: CLLocationCoordinate2D?
    var locationPlacemark: String?
    var meetingTime: Date?
    var role: Role?
    var status: Status?
    var userGroupId: String?
    var publicUserDataId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case locationPlacemark
        case meetingTime
        case role
        case status
        case userGroupId
        case publicUserDataId
    }
    
    init(_ title: String, _ location: CLLocationCoordinate2D, _ locationPlacemark: String, _ meetingTime: Date, _ role: Role, _ status: Status, _ userGroupId: String, _ publicUserDataId: String) {
        id = UUID().uuidString
        self.title = title
        self.location = location
        self.locationPlacemark = locationPlacemark
        self.meetingTime = meetingTime
        self.role = role
        self.status = status
        self.userGroupId = userGroupId
        self.publicUserDataId = publicUserDataId
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let title = data["title"] as? String else {
            return nil
        }
        
        guard let location = data["location"] as? CLLocationCoordinate2D else {
            return nil
        }
        
        guard let locationPlacemark = data["locationPlacemark"] as? String else {
            return nil
        }
        
        guard let meetingTime = data["meetingTime"] as? Date else {
            return nil
        }
        
        guard let role = data["role"] as? Role else {
            return nil
        }
        
        guard let status = data["status"] as? Status else {
            return nil
        }
        
        guard let userGroupId = data["userGroupId"] as? String else {
            return nil
        }
        
        guard let publicUserDataId = data["publicUserDataId"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.title = title
        self.location = location
        self.locationPlacemark = locationPlacemark
        self.meetingTime = meetingTime
        self.role = role
        self.status = status
        self.userGroupId = userGroupId
        self.publicUserDataId = publicUserDataId
    }
}

enum Role {
    case owner
    case admin
    case member
    case banned
}

extension Role: Codable {

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
        case "owner":
            self = .owner
        case "admin":
            self = .admin
        case "member":
            self = .member
        case "banned":
            self = .banned
        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .owner:
            try container.encode("owner", forKey: .rawValue)
        case .admin:
            try container.encode("admin", forKey: .rawValue)
        case .member:
            try container.encode("member", forKey: .rawValue)
        case .banned:
            try container.encode("banned", forKey: .rawValue)
        }
    }
}

enum Status: CaseIterable {
    case active
    case invited
    case requested
    case rejected
    case removed
}

extension Status: Codable {
    
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
            self = .active
        case 1:
            self = .invited
        case 2:
            self = .requested
        case 3:
            self = .rejected
        case 4:
            self = .removed
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .active:
            try container.encode(0, forKey: .rawValue)
        case .invited:
            try container.encode(1, forKey: .rawValue)
        case .requested:
            try container.encode(2, forKey: .rawValue)
        case .rejected:
            try container.encode(3, forKey: .rawValue)
        case .removed:
            try container.encode(4, forKey: .rawValue)
        }
    }
    
}
