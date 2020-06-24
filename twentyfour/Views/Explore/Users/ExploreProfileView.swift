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
     
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var tmpTitleString: String
    @Binding var tmpLocationString: String
    @Binding var tmpTimeString: String
    @Binding var tmpMeetingString: String
    
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
        VStack() {
            
            if groupList.count == 0 {
                HStack(){
                    Text("Finde Gleichgesinnte")
                        .foregroundColor(Color ("button1"))
                        .font(.avenirNextRegular(size: 20))
                        .fontWeight(.medium)
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 60)
            
                HStack(){
                    Text("Finde andere User mit gleichen Interessen und gründet Gruppen um zusammen etwas zu unternehmen, denn zusammen ist man weniger allein.")
                        .foregroundColor(Color ("button1"))
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.light)
                        .lineLimit(5)
                        .frame(height: 60)
//                        .padding(.bottom)
                        .padding(.horizontal)
                    Spacer()
                }
            } else {
                HeaderSectionView(
                selectedEventType: self.$selectedEventType,
                groupList: self.$groupList,
                tmpTitleString: self.$tmpTitleString,
                tmpLocationString: self.$tmpLocationString,
                tmpTimeString: self.$tmpTimeString,
                tmpMeetingString: self.$tmpMeetingString)
//                    .offset(y: 10)

                Spacer()
            }
            
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {

                ForEach(userData.appUsers) { profile in
                    GeometryReader { geometry in
                        RowItem(
                            profile: profile,
                            selectedEventType: self.$selectedEventType,
                            groupList: self.$groupList,
                            showProfile: self.$showProfile
                        )
//                            .rotation3DEffect(Angle(degrees:
//                                (Double(geometry.frame(in: .global).minX)) / -65
//                            ), axis: (x:0, y:10, z:0))
                    }
                    .frame(width: 280, height: 390)
                }
            }
        }
        .animation(.spring())
        Spacer()
        }
//        .navigationBarHidden(true)
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
    }
}

struct RowItem: View {
    var profile: Profile
    @State var deviceWidth = UIScreen.main.bounds.width - 20
    @State var deviceHeight = UIScreen.main.bounds.height - 300
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                self.profile.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.63 ,height: UIScreen.main.bounds.width*0.82)
//                    .frame(width: UIScreen.main.bounds.width*0.73 ,height: UIScreen.main.bounds.width*0.74)
                    .overlay(AppUserTextOverlay(
                        currentProfile: self.profile,
                        selectedEventType: self.$selectedEventType,
                        groupList: self.$groupList,
                        showProfile: $showProfile
                        )
                )
                .cornerRadius(15)
                .shadow(color: .init(red: 0.5, green: 0.5, blue: 0.5)
                , radius: 9 , x: 0, y: 4)
            }
//        .padding(10)
    }
}

struct AppUserTextOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var currentProfile: Profile
    @Binding var selectedEventType: EventType?
    
    @State var tempUser: Profile?
    @State var showInfoPanel: Bool = true
    @State var collapsedOffset: Int = 290
    
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    
    @State var showCard = false
    @State var userId: String = String()
    
    func setTopOpacity(profile: Profile) -> Color {
        if groupList.contains(profile) {
//            return Color.black.opacity(0.7)
            return Color.black.opacity(0.0)
        } else {
//            return Color.black.opacity(0.7)
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
//        self.isMenuCollapsed = false
//        self.isMenuMinimized = false
        userData.buttonBarOffset = CGFloat (150)
//        screenLock = true
    }
    
    func closeCreateGroupMenu() {
//        self.isMenuCollapsed = true
//        self.isMenuMinimized = false
        userData.buttonBarOffset = CGFloat (0)
//        screenLock = false
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [setBottomOpacity(profile: currentProfile), setTopOpacity(profile: currentProfile)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    func printGeoValue(geo: GeometryProxy) -> CGFloat {
        print("width: \(geo.size.width)")
        print("height: \(geo.size.height)")
        return 50
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

        GeometryReader { geometry in
        ZStack(alignment: .bottomLeading) {
            
            // Black Overlay
            VStack() {
                
                Spacer()
                
                HStack() {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(self.currentProfile.username)
                            .foregroundColor(Color ("button1_inverted"))
//                            .font(.avenirNextRegular(size: 24))
                            .font(.avenirNextRegular(size: 20))
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.horizontal)
                        Text(self.currentProfile.searchParameter.locationName)
                            .foregroundColor(Color ("button1_inverted"))
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    Spacer()
                    
                    VStack() {
                        
                        Spacer()

                        Button(action: {
                            self.didPressAddRemoveButton(profile: self.currentProfile)
                        }) {
                            Image(systemName: self.groupList.contains(self.currentProfile) ? "checkmark" : "plus")
                                .font(.system(size: 24, weight: .medium))
                        }
                        .foregroundColor(Color ("button1_inverted"))
                        .padding(.bottom)
                        .padding(.horizontal)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height/5)
                .background(self.gradient)
            }
        }
        }
    }
}

