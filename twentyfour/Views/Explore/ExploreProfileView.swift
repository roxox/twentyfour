//
//  HomeProfileView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import UIKit
//import Combine

struct ExploreProfileView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
     
    @Binding var screenLock: Bool
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var isMenuMinimized: Bool
    @Binding var isMenuCollapsed: Bool
    
    @State var showProfile = false
    

  
    
    func addToGroupList(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    var body: some View {
//        VStack() {
//        if self.searchData.isSearchActive == true {
//            Text("Hallo")
//        }

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {

                ForEach(userData.appUsers) { profile in
                    GeometryReader { geometry in
                        RowItem(
                            profile: profile,
                            selectedEventType: self.$selectedEventType,
                            screenLock: self.$screenLock,
                            groupList: self.$groupList,
                            isMenuMinimized: self.$isMenuMinimized,
                            isMenuCollapsed: self.$isMenuCollapsed,
                            showProfile: self.$showProfile
                        )
                            .rotation3DEffect(Angle(degrees:
                                (Double(geometry.frame(in: .global).minX)) / -65
                            ), axis: (x:0, y:10, z:0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 640)
                }
            }
        }
        .animation(.spring())
//    .animation(spri)
    }
}

struct RowItem: View {
    var profile: Profile
    @State var deviceWidth = UIScreen.main.bounds.width - 20
    @State var deviceHeight = UIScreen.main.bounds.height - 300
    @Binding var selectedEventType: EventType?
    @Binding var screenLock: Bool
    @Binding var groupList: [Profile]
    @Binding var isMenuMinimized: Bool
    @Binding var isMenuCollapsed: Bool
    @Binding var showProfile: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                self.profile.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: deviceWidth ,height: deviceHeight)
                    .overlay(AppUserTextOverlay(
                        currentProfile: self.profile,
                        selectedEventType: self.$selectedEventType,
                        screenLock: self.$screenLock,
                        groupList: self.$groupList,
                        isMenuMinimized: self.$isMenuMinimized,
                        isMenuCollapsed: self.$isMenuCollapsed,
                        showProfile: $showProfile
                        )
                )
                .cornerRadius(20)
                .shadow(color: .init(red: 0.5, green: 0.5, blue: 0.5)
                , radius: 9 , x: 0, y: 4)
            }
        .padding(10)
    }
}

struct AppUserTextOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var currentProfile: Profile
    @Binding var selectedEventType: EventType?
    @Binding var screenLock: Bool
    
    @State var tempUser: Profile?
    @State var showInfoPanel: Bool = true
//    @State var showProfile = false
    @State var collapsedOffset: Int = 290
    
    @Binding var groupList: [Profile]
    @Binding var isMenuMinimized: Bool
    @Binding var isMenuCollapsed: Bool
    @Binding var showProfile: Bool
    
    @State var showCard = false
    @State var userId: String = String()
    
    func setTopOpacity(profile: Profile) -> Color {
        if groupList.contains(profile) {
            return Color.black.opacity(0.7)
        } else {
            return Color.black.opacity(0.0)
        }
    }
    
    func setBottomOpacity(profile: Profile) -> Color {
        if groupList.contains(profile) {
            return Color.black.opacity(0.7)
        } else {
            return Color.black.opacity(0.6)
        }
    }
    
    func setOverlayPosition(profile: Profile) -> UnitPoint {
        if groupList.contains(profile) {
            return .top
        } else {
            return .center
        }
    }
        
    func addToGroupList(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
            if groupList.count == 1 {
                expandCreateGroupMenu()
            }
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
        if groupList.count == 0 {
            closeCreateGroupMenu()
        }
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    func didPressAddRemoveButton(profile: Profile) {
        if !groupList.contains(profile) {
            addToGroupList(profile: profile)
        } else {
            removeFromGroupList(profile: profile)

            if groupList.count == 0 {
                resetGroupValues()
            }
        }
    }
    
    func expandCreateGroupMenu() {
        self.isMenuCollapsed = false
        self.isMenuMinimized = false
        userData.buttonBarOffset = CGFloat (150)
        screenLock = true
    }
    
    func closeCreateGroupMenu() {
        self.isMenuCollapsed = true
        self.isMenuMinimized = false
        userData.buttonBarOffset = CGFloat (0)
        screenLock = false
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [setBottomOpacity(profile: currentProfile), setTopOpacity(profile: currentProfile)]),
            startPoint: .bottom,
            endPoint: setOverlayPosition(profile: currentProfile))
    }
    
    func getType(typeToTest: EventType) -> String{
        if typeToTest == .food {
            return "Essen und Trinken"
        }
        if typeToTest == .activity {
            return "Freizeit"
        }
        if typeToTest == .sport {
            return "Sport"
        }
        
        return ""
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            // Black Overlay
            Rectangle().fill(gradient)
            
            // Elements
//            HStack() {
                VStack() {
                    Spacer()
                    HStack(){
                        VStack(alignment: .leading){

                                Spacer()
                            
                                HStack(){
                                    Button(action: {
                                        self.showCard.toggle()
                                    }) {
                                    Text(currentProfile.username)
                                        .font(.avenirNextRegular(size: 30))
                                        .fontWeight(.semibold)
                                        .offset(y: 30)
                                    }
                                    Spacer()
                                }
                            
                                HStack(){
                                    Image("locationBlack")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 20, height: 20)
                                        .scaledToFill()
                                        .foreground(Color .white)
                                        .padding(.trailing, 10)
                                    
                                    Text(currentProfile.searchParameter.locationName)
                                        .font(.avenirNextRegular(size: 20))
                                        .allowsTightening(true)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                }
                                .offset(y: 7)
                            
//                                HStack(alignment: .top){
//                                    Image(systemName: "star.fill")
//                                        .resizable()
//                                        .renderingMode(.original)
//                                        .frame(width: 20, height: 20)
//                                        .scaledToFill()
//                                        .foreground(Color .white)
//                                        .padding(.trailing, 10)
//
//                                    VStack(alignment: .leading) {
//                                        ForEach(self.currentProfile.searchTypes, id: \.self) { typeIdentifier in
////                                            getType(typeToTest: typeIdentifier)
//                                            Text(self.getType(typeToTest: typeIdentifier))
//                                            .font(.avenirNextRegular(size: 20))
//                                            .allowsTightening(true)
//                                            .lineLimit(1)
//                                        }
//                                    }
//
//                                    Spacer()
//                                    }
                                .padding(.bottom, 30)
                        }
                        VStack(){
                            Spacer()

                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.didPressAddRemoveButton(profile: self.currentProfile)
                                }
                            }) {
                                Circle()
                                    .fill(groupList.contains(currentProfile) ? gradientPinkPinkAndPeach : gradientWhite)
                                    .overlay(
                                        HStack() {
                                            Image(systemName: groupList.contains(currentProfile) ? "checkmark" : "plus")
                                            .font(.system(size: 24, weight: .medium))
                                                .padding(.vertical, 10.0)
                                        }
                                        .font(.system(size: 20, weight: .medium))
                                        .foreground(groupList.contains(currentProfile) ? Color .white : Color .black)
                                )
                                    .frame(width: 50, height: 50)
                                    .offset(x: -4, y: 0)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.horizontal, 20)
//            }
            .sheet(isPresented: $showCard) {
                UserDetailsViewer(
                    user: self.currentProfile,
                    showCard: self.$showCard
                )
            }
        }
        .foregroundColor(.white)
    }
}

