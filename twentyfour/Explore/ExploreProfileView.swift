//
//  HomeProfileView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import UIKit

struct ExploreProfileView: View {
    @EnvironmentObject var userData: UserData
    
    var items: [Profile]
     
    @Binding var groupList: [Profile]
    @Binding var screenLock: Bool
    @Binding var profiles: [Profile]
    @Binding var currentUserEventSelection: [EventType]
    @Binding var tempEventSelection: [EventType]
    @Binding var selectedEventType: EventType?
    
//    @State var deviceWidth: UIScreen.main.bounds.width
    @State var showingMenu = false
    @State var activateGroup = false
    @State var requets: [Profile] = []
    @State private var currentPage = 0

    
    func addAppUserToRequests(profile: Profile) {
        requets.append(profile)
    }
    
    func addToGroupList(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
//            if (profiles.contains(profile)) {
//                profiles.remove(at: profiles.firstIndex(of: profile)!)
//            }
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: self.groupList.firstIndex(of: profile)!)
//            if !profiles.contains(profile) {
//                profiles.append(profile)
//            }
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
        
        if groupList.count != 0 {
            userData.createGroupMenuOffset = CGFloat (35)
            userData.mainMenuOffset = CGFloat (150)
            screenLock = true
        } else {
            userData.createGroupMenuOffset = CGFloat (455)
            userData.mainMenuOffset = CGFloat (0)
            screenLock = false
        }
    }
    
    func updateTempEventSelection(items: [EventType]) {
        for eventType in tempEventSelection {
            if !items.contains(eventType) {
                tempEventSelection.remove(at: tempEventSelection.firstIndex(of: eventType)!)
            }
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
//                    PagerView(pageCount: profiles.count, currentIndex: $currentPage) {
            HStack(alignment: .top, spacing: 0) {

                ForEach(self.profiles) { profile in
                    GeometryReader { geometry in
                        RowItem(
                            profile: profile,
                            groupList: self.$groupList,
                            selectedEventType: self.$selectedEventType,
                            screenLock: self.$screenLock)
                            .rotation3DEffect(Angle(degrees:
                                (Double(geometry.frame(in: .global).minX) - 0) / -20
                            ), axis: (x:0, y:15, z:0))
//                        .rotation3DEffect()
                        
                    }
//                    .frame(width: 246, height: 150)

                    .frame(width: UIScreen.main.bounds.width, height: 650)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct RowItem: View {
    var profile: Profile
    @State var deviceWidth = UIScreen.main.bounds.width - 40
    @State var deviceHeight = UIScreen.main.bounds.height - 350
    @Binding var groupList: [Profile]
    @Binding var selectedEventType: EventType?
    @Binding var screenLock: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                self.profile.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: deviceWidth ,height: deviceHeight)
//                .frame(width: 280 ,height: 360)
//                .frame(width: 310 ,height: 400)
                    .overlay(AppUserTextOverlay(profile: self.profile, groupList: self.$groupList, selectedEventType: self.$selectedEventType, screenLock: self.$screenLock))
//                .background(Color .white)
                .cornerRadius(25.0)
                .shadow(color: .init(red: 0.5, green: 0.5, blue: 0.5)
                , radius: 9 , x: 0, y: 4)
            }
        .padding(10)
    }
}

struct AppUserTextOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var profile: Profile
    @Binding var groupList: [Profile]
    @Binding var selectedEventType: EventType?
    @Binding var screenLock: Bool
    
    @State var tempUser: Profile?
    @State var showInfoPanel: Bool = true
    @State var showProfile = false
    @State var collapsedOffset: Int = 290
    
    func setTopOpacity(profile: Profile) -> Color {
        if groupList.contains(profile) {
            return Color.black.opacity(0.7)
//            return Color.black.opacity(0.0)
        } else {
            return Color.black.opacity(0.0)
        }
    }
    
    func setBottomOpacity(profile: Profile) -> Color {
        if groupList.contains(profile) {
            return Color.black.opacity(0.7)
//            return Color.black.opacity(0.6)
        } else {
            return Color.black.opacity(0.6)
        }
    }
    
    func setOverlayPosition(profile: Profile) -> UnitPoint {
        if groupList.contains(profile) {
//            return .top
            return .center
        } else {
            return .center
        }
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [setBottomOpacity(profile: profile), setTopOpacity(profile: profile)]),
            startPoint: .bottom,
            endPoint: setOverlayPosition(profile: profile))
    }

    var gradientColorPrimary: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    .pink,
                    .pink,
                    Color ("Peach")
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
        
    var gradientColorSecondary: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color .white,
                    Color .white,
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
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
            groupList.remove(at: self.groupList.firstIndex(of: profile)!)
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
        userData.createGroupMenuOffset = CGFloat (35)
        userData.mainMenuOffset = CGFloat (150)
        screenLock = true
    }
    
    func collapseCreateGroupMenu() {
        userData.createGroupMenuOffset = CGFloat (collapsedOffset)
    }
    
    func closeCreateGroupMenu() {
        userData.createGroupMenuOffset = CGFloat (455)
        userData.mainMenuOffset = CGFloat (0)
        screenLock = false
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            
            HStack() {
                VStack() {
                    Spacer()
                    HStack(){
                        VStack(alignment: .leading){

                            Spacer()
                                HStack(){

                                    // Button 1
                                    NavigationLink(
                                        destination: ProfileDetail(
                                            profile: profile,
                                            showProfile: self.$showProfile
                                        ),
                                        isActive : self.$showProfile
                                    ) {
                                    Text(profile.username)
                                        .font(.avenirNextRegular(size: 22))
                                        .fontWeight(.bold)
                                        .offset(y: 15)
                                        
                                    }
                                    Spacer()
                                }
                                HStack(){
                                                            
                                    Image("locationBlack")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 16, height: 16)
                                        .scaledToFill()
                                        .foreground(makeGradient(colors: [.white, .white]))
                                    
                                    Text(profile.searchParameter.locationName)
                                        .font(.avenirNextRegular(size: 16))
                                        .allowsTightening(true)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                }
                            
                            .padding(.bottom, 20)
                        }
                        VStack(){
                            Spacer()

                            Button(action: {
                                
                                withAnimation(.linear(duration: 0.2)) {
                                    self.didPressAddRemoveButton(profile: self.profile)
                                }
                            }) {
                                Circle()
                                    .fill(groupList.contains(profile) ? gradientColorPrimary : gradientColorSecondary)
                                    .overlay(
                                        HStack() {
                                            Image(systemName: groupList.contains(profile) ? "checkmark" : "plus")
                                                .padding(.vertical, 10.0)
                                        }
                                        .font(.system(size: 20, weight: .medium))
                                        .foreground(groupList.contains(profile) ? Color .white : Color .black)
                                )
                                    .frame(width: 40, height: 40)
                                    .offset(x: -4, y: 0)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .foregroundColor(.white)
    }
}

struct ExploreProfileView_Previews: PreviewProvider {
    @State static var groupList = appUserData // Note: it must be static
    @State static var profiles = appUserData // Note: it must be static
    @State static var screenLock = false // Note: it must be static
    @State static var currentUserEventSelection: [EventType] = [.food, .activity] // Note: it must be static
    @State static var tempEventSelection: [EventType] = [.food, .activity] // Note: it must be static
    @State static var selectedEventType: EventType? = EventType.food // Note: it must be static

    static var previews: some View {
            return ExploreProfileView(
                items: Array(appUserData.prefix(4)),
                groupList: $groupList,
                screenLock: $screenLock,
                profiles: $profiles,
                currentUserEventSelection: $currentUserEventSelection,
                tempEventSelection: $tempEventSelection,
                selectedEventType: $selectedEventType
            )
        }
}

