//
//  Group.swift
//  twentyfour
//
//  Created by Sebastian Fox on 29.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

struct Group: Hashable, Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var requests: [GroupRequest]?
    var administrators: [Profile]?
    var participants: [Profile]?
    var type: EventType?
    
    init() {
//        id = nil
        administrators = []
        participants = []
//        description = "test"
        requests = []
//        title = ""
//        type = "test"
    }
    
    mutating func addAdminstrator(user: Profile) {
        administrators?.append(user)
    }
}

struct GroupRequest: Hashable, Codable, Identifiable {
    var id: String
    var user: Profile
    var description: String
    var isInvitation: Bool
    
}

struct Type: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    
}
