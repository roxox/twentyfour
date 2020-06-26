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
    
    
    @GestureState private var isTapped = false
    @GestureState private var translation: CGFloat = 0
    @GestureState private var movement: CGFloat = 0
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false
     
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
                        .scaleEffect(isDragging ? 1.5 : 1)
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
                    }
                    .frame(width: 244, height: 320)
                }
            }
        }
        .padding(.bottom, 15)
//           .simultaneousGesture(
//               DragGesture(minimumDistance: 0).updating(self.$isTapped) { value, isTapped, _ in
//                isTapped = true
//                print("Touch down")
//               }
//        )
        
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
    
    @State var scaler: CGFloat = 1.0
    
    @GestureState private var isTapped = false
    @GestureState private var translation: CGFloat = 0
    @GestureState private var movement: CGFloat = 0
    
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    @Binding var isButtonBarHidden: Bool
    
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
    
    func setScaler(scale: CGFloat) {
        print(scale)
        scaler = scale
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(){
                    self.profile.image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                }
                .frame(width: UIScreen.main.bounds.width*0.55 ,height: UIScreen.main.bounds.width*0.67)
//                    .frame(width: UIScreen.main.bounds.width*0.55 ,height: UIScreen.main.bounds.width*0.73)
                .overlay(AppUserTextOverlay(
                    currentProfile: self.profile,
                    selectedEventType: self.$selectedEventType,
                    groupList: self.$groupList,
                    showProfile: $showProfile,
                    isButtonBarHidden: self.$isButtonBarHidden
                    )
                )
                .cornerRadius(10)
                .shadow(radius: 7, y: 4)
                .scaleEffect(self.isTapped ? 0.95 : 1.0)
                    
                    
                           .simultaneousGesture(
                               DragGesture(minimumDistance: 0).updating(self.$isTapped) { value, isTapped, _ in
                                isTapped = true
                                print("Touch down")
                               }
                        )
                    
                    
        .padding(10)
        }
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
//
//
//                        HStack() {
//                                Text("Essen und Trinken  Freizeit und Sport")
//                                .font(.avenirNextRegular(size: 11))
//                                .foregroundColor(Color ("button1_inverted"))
//                                .fontWeight(.semibold)
//                                .padding(.top)
//                                .padding(.horizontal, 5)
//
//                            Spacer()
//                        }
                        
                       NavigationLink(
                           destination: GroupDetail()

                       ) {
                           Text(self.currentProfile.username)
                               .foregroundColor(Color ("button1_inverted"))
                               .font(.avenirNextRegular(size: 17))
                               .fontWeight(.bold)
                               .padding(.top)
                               .padding(.horizontal)
                       }
                       .buttonStyle(BorderlessButtonStyle())

                        HStack() {

                            Text(self.currentProfile.searchParameter.locationName)
                                .foregroundColor(Color ("button1_inverted"))
                                .font(.avenirNextRegular(size: 13))
                                .fontWeight(.light)
                                .padding(.leading)
                        }
////                        .offset(y: -10)
                        .padding(.bottom, 10)
//
                    }
                    Spacer()
                    
                    VStack() {
//
                        Spacer()

                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.didPressAddRemoveButton(profile: self.currentProfile)
                            }
                        }) {

//                                                    Image(systemName: self.groupList.contains(self.currentProfile) ? "checkmark" : "person.badge.plus.fill")
                            Image(systemName: self.groupList.contains(self.currentProfile) ? "checkmark" : "person.badge.plus.fill")
                                .font(.system(size: 24, weight: .medium))
                                .fixedSize()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        .shadow(radius: 4, y: 2)
                        .padding(.trailing, 15)
                        .padding(.bottom, 15)
                        .padding(.top, 10)
                        
//                        Spacer()
                    }
                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(self.gradient)
            }
        }
        }
    }
}

