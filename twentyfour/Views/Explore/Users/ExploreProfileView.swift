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
    @Binding var isButtonBarHidden: Bool
    
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
                        .font(.avenirNextRegular(size: 16))
                        .fontWeight(.light)
                        .lineLimit(5)
                        .frame(height: 90)
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
                tmpMeetingString: self.$tmpMeetingString,
                isButtonBarHidden: self.$isButtonBarHidden)
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
                            showProfile: self.$showProfile,
                            isButtonBarHidden: self.$isButtonBarHidden
                        )
//                            .rotation3DEffect(Angle(degrees:
//                                (Double(geometry.frame(in: .global).minX)) / -65
//                            ), axis: (x:0, y:10, z:0))
                    }
                    .frame(width: 250, height: 350)
                }
            }
        }
        .padding(.bottom, 30)
        
//        .animation(.spring())
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
    @Binding var isButtonBarHidden: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                self.profile.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.55 ,height: UIScreen.main.bounds.width*0.73)
//                    .frame(width: UIScreen.main.bounds.width*0.73 ,height: UIScreen.main.bounds.width*0.74)
                    .overlay(AppUserTextOverlay(
                        currentProfile: self.profile,
                        selectedEventType: self.$selectedEventType,
                        groupList: self.$groupList,
                        showProfile: $showProfile,
                        isButtonBarHidden: self.$isButtonBarHidden
                        )
                )
                .cornerRadius(20)
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
    @Binding var isButtonBarHidden: Bool
    
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
            return Color.black.opacity(0.6)
        } else {
            return Color.black.opacity(0.6)
        }
    }
    
    func setOverlayPosition(profile: Profile) -> UnitPoint {
        if groupList.contains(profile) {
            return .center
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
//        userData.buttonBarOffset = CGFloat (150)
        isButtonBarHidden = true
//        screenLock = true
    }
    
    func closeCreateGroupMenu() {
//        self.isMenuCollapsed = true
//        self.isMenuMinimized = false
//        userData.buttonBarOffset = CGFloat (0)
        isButtonBarHidden = false
//        screenLock = false
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [setBottomOpacity(profile: currentProfile), setTopOpacity(profile: currentProfile)]),
            startPoint: .bottom,
            endPoint: setOverlayPosition(profile: currentProfile))
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
                        
                        
                       NavigationLink(
                           destination: GroupDetail()

                       ) {
                           Text(self.currentProfile.username)
                               .foregroundColor(Color ("button1_inverted"))
                               .font(.avenirNextRegular(size: 20))
                               .fontWeight(.semibold)
                               .padding(.top)
                               .padding(.horizontal)
                       }
                       .buttonStyle(BorderlessButtonStyle())
                        
                        HStack() {
                            
                            
                            Image("locationBlack")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 16, height: 16)
                                .scaledToFill()
                                .foreground(gradientWhite)
                                .padding(.leading)
                            
//                            Image(systemName: "location.fill")
//                                .font(.system(size: 14, weight: .medium))
//                                .fixedSize()
//                                .frame(width: 14, height: 14)
//                                .foregroundColor(.white)
//                                .padding(.leading)
                            
                            Text(self.currentProfile.searchParameter.locationName)
                                .foregroundColor(Color ("button1_inverted"))
                                .font(.avenirNextRegular(size: 14))
                                .fontWeight(.light)
                                .padding(.trailing)
                        }
                        .offset(y: -10)
                        .padding(.bottom, 10)
                        
                    }
                    Spacer()
                    
                    VStack() {
                        
                        Spacer()

                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.didPressAddRemoveButton(profile: self.currentProfile)
                            }
                        }) {
                            Image(systemName: self.groupList.contains(self.currentProfile) ? "checkmark" : "plus")
                                .font(.system(size: 24, weight: .medium))
                                .frame(width: 26, height: 26)
                                .foreground(self.groupList.contains(self.currentProfile) ? gradientAccentSea : gradientWhite)
                        }
//                        .foregroundColor(Color ("button1_inverted"))
                        .padding(.bottom)
                        .padding(.horizontal)
                    }
                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(self.gradient)
            }
        }
        }
    }
}

