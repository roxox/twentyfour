//
//  GroupDataContainer.swift
//  twentyfour
//
//  Created by Sebastian Fox on 17.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class GroupDataContainer: ObservableObject {

    var title: String = ""
    var description: String = ""
    var groupList: [Profile] = []
    var eventType: EventType?
    var locationString: String = ""
    
    func createGroup() {
        
    }
}
