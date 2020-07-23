//
//  UserDefaultValues.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserDefaultValues: Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    let uid: String?
    var maxDistance: Double?
    
    init(uid: String) {
        id = UUID().uuidString
        maxDistance = 2
        self.uid = uid
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let maxDistance = data["maxDistance"] as? Double else {
            return nil
        }
        
        guard let uid = data["uid"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.maxDistance = maxDistance
        self.uid = uid
    }
}

extension UserDefaultValues: DatabaseRepresentation {
    
    var representation: [String : Any] {
        var rep = [
            "uid": uid,
            "maxDistance": maxDistance
        ] as [String : Any]
        
        if let id = id {
            rep["id"] = id
        }
        
        return rep
    }
}

enum Gender {
    case male
    case female
    case divers
}

extension Gender: Codable {
    
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
        case "male":
            self = .male
        case "female":
            self = .female
        case "divers":
            self = .divers
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .male:
            try container.encode("male", forKey: .rawValue)
        case .female:
            try container.encode("female", forKey: .rawValue)
        case .divers:
            try container.encode("divers", forKey: .rawValue)
        }
    }
}
