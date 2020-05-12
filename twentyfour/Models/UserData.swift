/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores app data.
*/

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var appUsers = appUserData
    @Published var currentUser = appUserData[0]
    
//    Menu offsets
    // Button Bar
    @Published var buttonBarOffset = CGFloat (0)
    
    // CreateGroup
    @Published var createGroupMenuOffsetY = CGFloat (555)
    @Published var createGroupMenuOffsetX = CGFloat (0)
    
    // AddTitleAndDescription
    @Published var addTitleMenuOffsetX = -UIScreen.main.bounds.width
    
    // SearchView
    @Published var searchViewOffsetY = UIScreen.main.bounds.height
    
//    @Published var profile: Profile.default
}
