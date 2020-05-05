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
    
//    Menu offsets
    @Published var mainMenuOffset = CGFloat (0)
    @Published var createGroupMenuOffset = CGFloat (455)
    
//    @Published var profile: Profile.default
}
