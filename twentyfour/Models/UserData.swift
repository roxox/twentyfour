/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores app data.
*/

//import Combine
import SwiftUI

let menuCollapsed: CGFloat = UIScreen.main.bounds.height

final class UserData: ObservableObject {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var showFavoritesOnly = false
    @Published var showInfoTexts = false
    @Published var appUsers = appUserData
    @Published var appGroups = appGroupData
    @Published var currentUser = appUserData[0]
    @Published var groupList: [AppUserGroup] = []
    @Published var publicUserData: PublicUserData?
        
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
    
    func resetValues() {
        groupList.removeAll()
    }
}
