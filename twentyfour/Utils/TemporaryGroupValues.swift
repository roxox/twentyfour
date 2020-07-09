//
//  TemporaryGroupValues.swift
//  twentyfour
//
//  Created by Sebastian Fox on 03.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI

final class TemporaryGroupValues: ObservableObject {
    @Published var tmpTitleString: String = ""
    @Published var tmpDescriptionString: String = ""
    @Published var tmpLocationString: String = ""
    @Published var tmpTimeString: String = ""
    @Published var tmpMeetingString: String = ""
    @Published var tmpDateMode: Bool = false
    @Published var groupList: [AppUser] = []
    @Published var tmpActivityType: ActivityType?
    
    func resetGroupValues() {
        tmpTitleString = ""
        tmpDescriptionString = ""
        tmpTimeString = ""
        tmpMeetingString = ""
        tmpLocationString = ""
        tmpDateMode = false
        groupList.removeAll()
        tmpActivityType = nil
    }
}
