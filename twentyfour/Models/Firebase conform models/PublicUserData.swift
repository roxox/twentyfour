//
//  PublicUserData.swift
//  twentyfour
//
//  Created by Sebastian Fox on 19.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PublicUserData: Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    let uid: String?
    var username: String?
    var email: String?
    var userDescription: String = "Hier könnte eine kleine Beschreibung über dich stehen."
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case username
        case email
        case userDescription = "description"
    }
    
    init(uid: String, username: String, email: String, userDescription: String) {
        id = UUID().uuidString
        self.username = username
        self.email = email
        self.userDescription = userDescription
        self.uid = uid
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let username = data["username"] as? String else {
            return nil
        }
        
        guard let email = data["email"] as? String else {
            return nil
        }
        
        guard let userDescription = data["userDescription"] as? String else {
            return nil
        }
        
        guard let uid = data["uid"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.username = username
        self.email = email
        self.userDescription = userDescription
        self.uid = uid
        
//
//        return try? document.data(as: PublicUserData.self)
    }
}

//extension PublicUserData {
//    var image: Image?
//}

//extension PublicUserData: DatabaseRepresentation {
//
//    var representation: [String : Any] {
//        var rep = [
//            "uid": uid,
//            "username": username,
//            "email": email,
//            "userDescription": userDescription
//        ]
//
//        if let id = id {
//            rep["id"] = id
//        }
//
//        return rep
//    }
//}
