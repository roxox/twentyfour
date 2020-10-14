//
//  ExploreView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
//import SwiftUIPager

struct ExploreView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchData
    @EnvironmentObject var session: FirebaseSession
    
    // Editable values
    @State var selectedEventType: ActivityType?
    @State var groupList: [AppUser] = []
    @State var showSubTexts = true
    @State var remainingTime: Int = 0
    @State var tmpValues = TemporaryGroupValues()
    
    
    @State private var favoriteColor = 0
    
    // Bindings
    @Binding var isButtonBarHidden: Bool
    @Binding var showSearch: Bool
    
    
    var items = Array(0..<10)
    @State var page: Int = 0
    
    func secondsToHours (seconds : Int) -> (Int) {
        return (Int(seconds) / 3600)
    }
    
    func secondsToMinutes (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) / 60)
    }
    
    func secondsToSeconds (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) % 60)
    }
    
    // TESTWERTE
    var buttonGradientA: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                    [
                        Color ("buttonGradient1"),
                        Color ("buttonGradient2"),
                    ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var buttonGradientB: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                    [
                        Color ("buttonGradient3"),
                        Color ("buttonGradient4"),
                    ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var buttonGradientC: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                    [
                        Color ("buttonGradient5"),
                        Color ("buttonGradient6"),
                    ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack() {
                
                VStack(){
                    
                    ScrollView(self.groupList.count == 0 ? [.vertical] : [.vertical], showsIndicators: false) {
                        ScrollViewReader { scrollView in
                            
                            
//                            if self.groupList.count == 0 {
//                                
//                                    VStack(){
//                                                HStack() {
//                                                    Text("Finde neue Freunde und gründe Gruppen")
//                                                        .font(.avenirNextRegular(size: 22))
//                                                        .fontWeight(.medium)
//                                                        .padding(.horizontal, 26)
//                                                    Spacer()
//                                                }
//                                        
//                                                    HStack() {
//                                                        Text("Egal ob zugezogen, auf Dienstreise oder nur so noch ohne Freunde, hier findest du bestimmt Gleichgesinnte.")
//                                                            .font(.avenirNextRegular(size: 16))
//                                                            .padding(.horizontal, 26)
//                                                        Spacer()
//                                                    }
//                                                    .padding(.top, 16)
//                                                    .padding(.bottom, 25)
//                                        Spacer()
//                                    }
//                                    .padding(.top, 120)
//                                
//                            }
                            
                            
                            VStack() {
                                Spacer()
                                
                                if self.session.isOwnSearchActive == true {
                                    AppUserListView(
                                        searchData: searchData,
                                        selectedEventType: $selectedEventType,
                                        //                                        groupList: $groupList,
                                        groupList: self.$groupList,
                                        isButtonBarHidden: self.$isButtonBarHidden,
                                        tmpValues: self.$tmpValues
                                    )
                                    .padding(.top, self.groupList.count == 0 ? 0 : 50)
                                }
                            }
                        }
                    }
                    if self.groupList.count == 0 {
                        Rectangle().fill(Color .clear)
                            .frame(height: 30)
                    }
                }
//                .animation(.spring())
                
                VStack(){
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.top)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                
                VStack() {
                    ExploreSearchButtonView(
                        searchData: searchData,
                        showSearch: self.$showSearch
                    )
                    .offset(y: 0)
                    
                    Spacer()
                }
                .offset(y: self.groupList.count == 0 ? 0 : -150)
                
                if self.groupList.count != 0  {
                    VStack() {
                        CreateGroupNavigation(
                            selectedEventType: self.$selectedEventType,
                            groupList: self.$groupList,
                            isButtonBarHidden: self.$isButtonBarHidden,
                            tmpValues: tmpValues
                        )
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

//struct ExploreView_Previews: PreviewProvider {
//    @State static var pageIndex_old = 0 // Note: it must be static
//    @State static var pageIndex = 0 // Note: it must be static
////    @State static var groupList = appUserData // Note: it must be static
//    
//    static var previews: some View {
//            let userData = UserData()
//            return ExploreView(
//                items: Array(appUserData.prefix(4)),
//                pageIndex_old: $pageIndex_old,
//                pageIndex: $pageIndex
//            )
//            .environmentObject(userData)
//    }
//}

struct CreateGroupNavigation: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var session: FirebaseSession
    @Binding var selectedEventType: ActivityType?
    @Binding var groupList: [AppUser]
    @Binding var isButtonBarHidden: Bool
    @ObservedObject var tmpValues: TemporaryGroupValues
    
    func deleteGroupList() {
        self.groupList.removeAll()
        resetGroupValues()
        
        if self.groupList.count != 0 {
            isButtonBarHidden = true
        } else {
            isButtonBarHidden = false
        }
    }
    
    func resetGroupValues() {
        selectedEventType = nil
        tmpValues.resetGroupValues()
    }
    
    func getActivityString(eventType: ActivityType) -> String {
        switch eventType {
        case .food:
            return "Essen & Trinken"
        case .leisure:
            return "Freizeit"
        case .sports:
            return "Sport"
        }
    }
    
    func save() {
        var group = AppUserGroup()
        group.title = tmpValues.tmpTitleString
        group.activityType = tmpValues.tmpActivityType
        group.imageName = "sport"
        
        for user in groupList {
            let userIndex = groupList.firstIndex(of: user)
            //            let membership = group.inviteMember(user: &groupList[userIndex!])
            //            groupList[userIndex!].addMembership(membership: membership)
        }
        userData.appGroups.append(group)
        
        let location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let geopoint = GeoPoint(latitude: 0.0, longitude: 0.0)
        let userGroup = UserGroup(title: tmpValues.tmpTitleString, description: "", location: geopoint, locationPlacemark: "", datemode: false, eventType: .leisure, memberscount: 1)
        session.addUserGroup(group: userGroup)
        
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(){
                VStack(){
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.top)
                    ZStack() {
                        HStack(){
                            Button(action: {
                                self.deleteGroupList()
                            }) {
                                HStack(){
                                    
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 18, height: 18)
                                }
                                .frame(height: 36)
                                .foregroundColor(Color ("button1"))
                            }
                            
                            Spacer()
                            
                            Text("erstellen")
                                .font(.avenirNextRegular(size: 15))
                                .fontWeight(.bold)
                                .underline()
                        }
                        .padding(.horizontal, 20)
                        
                        //            .padding(.top, 12)
                        HStack(alignment: .center){
                            Spacer()
                            Text("Neue Gruppe")
                                .font(.avenirNextRegular(size: 15))
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    //                    Divider()
                }
                .background(Color ("background1"))
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
