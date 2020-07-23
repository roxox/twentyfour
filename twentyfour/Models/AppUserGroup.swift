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

struct AppUserGroup: Codable, Identifiable {
    
    var id: String?
    var title: String?
    var description: String?
//    var memberships: [Membership]?
    var activityType: ActivityType?
//    fileprivate var imageName: String?
    var imageName: String?
    
//    var invitedMembers: [Membership] {
//        memberships!.filter {
//            if case UserGroupStatus.invited = $0.status { return true }
//            return false
//        }
//    }
//
//    var requestedMembers: [Membership] {
//        memberships!.filter {
//            if case UserGroupStatus.requested = $0.status { return true }
//            return false
//        }
//    }
    
//    var activeMembers: [Membership] {
//        memberships!.filter {
//            if case UserGroupStatus.active = $0.status { return true }
//            return false
//        }
//    }
//
//    var rejectedMembers: [Membership] {
//        memberships!.filter {
//            if case UserGroupStatus.rejected = $0.status { return true }
//            return false
//        }
//    }
    
    init() {
//        memberships = []
    }
    
//    mutating func addGroupMembership(user: inout AppUser, role: UserGroupRole, status: UserGroupStatus) -> Membership {
//        let membership = Membership(user: user, group: self, role: role, status: status)
//        memberships?.append(membership)
//        return membership
//    }
    
//    mutating func inviteMember(user: inout AppUser) -> Membership {
//        let membership = addGroupMembership(user: &user, role: .member, status: .invited)
//        return membership
//    }
//
//    mutating func requestMembership(user: inout AppUser) -> Membership {
//        let membership = addGroupMembership(user: &user, role: .member, status: .requested)
//        return membership
//    }
    
//    mutating func inviteMember(member: UserToGroupRelationShip) {
//        let memberIndex = members?.firstIndex(of: member)
//        members![memberIndex!].status = .invited
//    }
//
//    mutating func requestMember(member: UserToGroupRelationShip) {
//        let memberIndex = members?.firstIndex(of: member)
//        members![memberIndex!].status = .requested
//    }
    
//    mutating func approveMember(member: Membership) {
//        let memberIndex = memberships?.firstIndex(of: member)
//        memberships![memberIndex!].status = .active
//    }
//
//    mutating func rejectMember(member: Membership) {
//        let memberIndex = memberships?.firstIndex(of: member)
//        memberships![memberIndex!].status = .rejected
//    }
}

struct GroupRequest: Hashable, Codable, Identifiable {
    var id: String
    var user: AppUser
    var description: String
    var isInvitation: Bool
    
}

struct Type: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    
}

extension AppUserGroup {
    var image: Image {
        ImageStore.shared.image(name: imageName!)
    }
}

enum UserGroupRole: CaseIterable {
    case owner
    case admin
    case member
    case banned
}

extension UserGroupRole: Codable {
    
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
            self = .owner
        case 1:
            self = .admin
        case 2:
            self = .member
        case 3:
            self = .banned
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .owner:
            try container.encode(0, forKey: .rawValue)
        case .admin:
            try container.encode(1, forKey: .rawValue)
        case .member:
            try container.encode(2, forKey: .rawValue)
        case .banned:
            try container.encode(3, forKey: .rawValue)
        }
    }
    
}

enum UserGroupStatus: CaseIterable {
    case active
    case invited
    case requested
    case rejected
    case removed
}

extension UserGroupStatus: Codable {
    
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

//struct Membership: Hashable, Codable {
//    var user: AppUser
//    var group: AppUserGroup
//    var role: UserGroupRole
//    var status: UserGroupStatus
//
//    init(user: AppUser, group: AppUserGroup, role: UserGroupRole, status: UserGroupStatus) {
//        self.user = user
//        self.group = group
//        self.role = role
//        self.status = status
//    }
//}


 
//func ==(lhs: UserGroupStatus, rhs: UserGroupStatus) -> Bool {
//    switch (lhs, rhs) {
////    case (.active, .active):
////        return lStr == rStr
////
////    case (.invited, .invited):
////        return lStr == rStr
////
////    case (.requested, .requested):
////        return lStr == rStr
////    }
//    return lhs == rhs
//}
