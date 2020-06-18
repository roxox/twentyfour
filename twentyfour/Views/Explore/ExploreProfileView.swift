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
    @Binding var profiles: [Profile]
    @Binding var currentUserEventSelection: [EventType]
    @Binding var tempEventSelection: [EventType]
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile] {
        didSet {
            print("Hallo1")
        }
    }
    
    @State var showingMenu = false
    @State var activateGroup = false
    @State var requets: [Profile] = []
    @State private var currentPage = 0
    
    @State var remainingTime: Int = 0
    @State var localTargetTime: Date = Date()
    @State var localCurrentTime: Date = Date()
    @State var localCreatedTime: Date = Date()
    
    @State var isActiveOnView: Bool = false

    
    func addAppUserToRequests(profile: Profile) {
        requets.append(profile)
    }
    
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

    func secondsToHours (seconds : Int) -> (Int) {
        return (Int(seconds) / 3600)
    }

    func secondsToMinutes (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) / 60)
    }

    func secondsToSeconds (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) % 60)
    }
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: searchDataContainer.created)
        return dateString
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
                            groupList: self.$groupList
                        )
                            .rotation3DEffect(Angle(degrees:
                                (Double(geometry.frame(in: .global).minX)) / -65
                            ), axis: (x:0, y:10, z:0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 590)
                }
            }
        }
        .onReceive(self.searchDataContainer.targetDateWillChange) { newValue in
            withAnimation(.linear(duration: 0.2)) {
                self.localTargetTime = newValue
            }
        }
        .onReceive(self.searchDataContainer.currentTimeWillChange) { newValue in
            withAnimation(.linear(duration: 0.2)) {
                self.localCurrentTime = newValue
            }
        }
        .onReceive(self.searchDataContainer.createdDateWillChange) { newValue in
            withAnimation(.linear(duration: 0.2)) {
                self.localCreatedTime = newValue
            }
        }
        .onReceive(self.searchDataContainer.remainingTimeWillChange) { newValue in
            withAnimation(.linear(duration: 0.2)) {
                self.remainingTime = newValue
            }
        }
        .animation(.spring())
//    .animation(spri)
    }
}

struct RowItem: View {
    var profile: Profile
    @State var deviceWidth = UIScreen.main.bounds.width - 40
    @State var deviceHeight = UIScreen.main.bounds.height - 350
    @Binding var selectedEventType: EventType?
    @Binding var screenLock: Bool
    @Binding var groupList: [Profile] {
        didSet {
            print("Hallo2")
        }
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                self.profile.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: deviceWidth ,height: deviceHeight)
                    .overlay(AppUserTextOverlay(
                        profile: self.profile,
                        selectedEventType: self.$selectedEventType,
                        screenLock: self.$screenLock,
                        groupList: self.$groupList)
                )
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
    @Binding var selectedEventType: EventType?
    @Binding var screenLock: Bool
    
    @State var tempUser: Profile?
    @State var showInfoPanel: Bool = true
    @State var showProfile = false
    @State var collapsedOffset: Int = 290
    
    @Binding var groupList: [Profile] {
        didSet {
            print("Hallo3")
        }
    }
    
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
//        let additionalHeight = 90*self.groupList.count
//        menuMinimized3 = UIScreen.main.bounds.height/3 + 110 + CGFloat(additionalHeight)
    }
    
    func expandCreateGroupMenu() {
        userData.createGroupMenuOffsetY = menuExpanded
        userData.buttonBarOffset = CGFloat (150)
        screenLock = true
    }
    
    func collapseCreateGroupMenu() {
        userData.createGroupMenuOffsetY = menuMinimized3
    }
    
    func closeCreateGroupMenu() {
        userData.createGroupMenuOffsetY = menuCollapsed
        userData.buttonBarOffset = CGFloat (0)
        screenLock = false
    }
    
    func getEventTypeString(eventTypes: [EventType]) -> String {
        var returnString = ""
        
        return returnString
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [setBottomOpacity(profile: profile), setTopOpacity(profile: profile)]),
            startPoint: .bottom,
            endPoint: setOverlayPosition(profile: profile))
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
                                    
                                    Text(profile.searchParameter.locationName)
                                        .font(.avenirNextRegular(size: 20))
                                        .allowsTightening(true)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                }
                                .offset(y: 7)
                            
                            HStack(alignment: .top){
                                                            
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 20, height: 20)
                                        .scaledToFill()
                                        .foreground(Color .white)
                                        .padding(.trailing, 10)
                                    
                                    Text("Essen und Trinken \nFreizeit \nSport")
                                        .font(.avenirNextRegular(size: 20))
                                        .allowsTightening(true)
                                        .lineLimit(3)
                                    
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
                                    .fill(groupList.contains(profile) ? gradientPinkPinkAndPeach : gradientWhite)
                                    .overlay(
                                        HStack() {
                                            Image(systemName: groupList.contains(profile) ? "checkmark" : "plus")
                                            .font(.system(size: 24, weight: .medium))
                                                .padding(.vertical, 10.0)
                                        }
                                        .font(.system(size: 20, weight: .medium))
                                        .foreground(groupList.contains(profile) ? Color .white : Color .black)
                                )
                                    .frame(width: 50, height: 50)
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

//struct ExploreProfileView_Previews: PreviewProvider {
////    @State static var groupList = appUserData // Note: it must be static
//    @State static var profiles = appUserData // Note: it must be static
//    @State static var screenLock = false // Note: it must be static
//    @State static var currentUserEventSelection: [EventType] = [.food, .activity] // Note: it must be static
//    @State static var tempEventSelection: [EventType] = [.food, .activity] // Note: it must be static
//    @State static var selectedEventType: EventType? = EventType.food // Note: it must be static
//
//    static var previews: some View {
//            return ExploreProfileView(
//
//                screenLock: $screenLock,
//                profiles: $profiles,
//                currentUserEventSelection: $currentUserEventSelection,
//                tempEventSelection: $tempEventSelection,
//                selectedEventType: $selectedEventType
//            )
//        }
//}

