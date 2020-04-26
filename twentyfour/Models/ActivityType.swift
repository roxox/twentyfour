//
//  ActivityType.swift
//  twentyfour
//
//  Created by Sebastian Fox on 24.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ActivityType {
    var id: String
    var name: String
    fileprivate var iconName: String
}


extension ActivityType {
    var icon: Image {
        SvnStore.shared.image(name: iconName)
    }
}
