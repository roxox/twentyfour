/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores app data.
*/

//import Combine
import SwiftUI

let menuCollapsed: CGFloat = UIScreen.main.bounds.height
var menuMinimized3: CGFloat = UIScreen.main.bounds.height/3 + 110
let menuExpanded: CGFloat = 0



let menuIn: CGFloat = 0
let menuLeftOut: CGFloat = -UIScreen.main.bounds.width

final class UserData: ObservableObject {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var showFavoritesOnly = false
    @Published var appUsers = appUserData
    @Published var appGroups = appGroupData
    @Published var currentUser = appUserData[0]
    @Published var groupList: [Group] = []
    
//    Menu offsets
    // Button Bar
    @Published var buttonBarOffset = CGFloat (0)
    
    // CreateGroup
    @Published var createGroupMenuOffsetY = menuCollapsed
    @Published var createGroupMenuOffsetX = menuIn
    
    // AddTitleAndDescription
    @Published var addTitleMenuOffsetX = menuLeftOut
    
    // SearchView
    @Published var searchViewOffsetY = UIScreen.main.bounds.height
    
    
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
