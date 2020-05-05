//
//  ExploreView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var userData: UserData
    
    var items: [Profile]
    @Binding var pageIndex: Int
    @Binding var groupList: [Profile]
    
    @State var showingMenu = false
    @State var activateGroup = false
    @State var showButtons = false
    @State var menuOffset = CGFloat (455)
    @State var requets: [Profile] = []
    @State var screenLock: Bool = true
    @State var profiles: [Profile] = appUserData
    @State var currentUserEventSelection: [EventType] = [.food, .activity]
    @State var tempEventSelection: [EventType] = [.food, .sport, .activity]
    @State var selectedEventType: EventType?
    @State private var currentPage = 0
        
    
    func addAppUserToRequests(appUser: Profile) {
        requets.append(appUser)
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func resetScreenLock() {
        screenLock.toggle()
//        userData.createGroupMenuOffset = CGFloat (255)
    }
    
    func setBackgroundColor () -> Color {
        if groupList.count == 0 {
            return Color .white
        }
        return Color ("SuperLightGray")
    }
    
    func setOpacity () -> Double {
        if profiles.count == 0 {
            return 1.0
        }
        return 0.85
    }
        
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("Sea"),
                    Color ("AmaBlue"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
        
        var gradientGray: LinearGradient {
            LinearGradient(
                gradient: Gradient(
                    colors:
                    [
                        Color ("SuperLightGray"),
                        Color ("BrightGray"),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
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

        var gradientColorThird: LinearGradient {
            LinearGradient(
                gradient: Gradient(
                    colors:
                    [
                        Color ("Violet"),
    //                    .pink,
                        Color ("Cherry")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
    
    var body: some View {
        ZStack() {
            
            ScrollView(.vertical, showsIndicators: false) {
//                VStack(alignment: .leading) {

                Rectangle().fill(Color .clear)
                    .frame(height: 60)

                        VStack() {
                            if pageIndex == 0 {
                                Spacer()
                                
                                HomeProfileView(items: appUserData,
                                                groupList: $groupList,
                                                screenLock: $screenLock,
                                                profiles: $profiles,
                                                currentUserEventSelection: $currentUserEventSelection,
                                                tempEventSelection: $tempEventSelection,
                                                selectedEventType: $selectedEventType
                                )
                                
                            
                                Spacer()
                            }
                        }
            }

            if groupList.count != 0 && screenLock {
//                Button(action: {
//                        self.resetScreenLock()
//                }) {
//                    ZStack(){

                                           
                        Rectangle().fill(Color .black.opacity(setOpacity()))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(minHeight: 0, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
////                    }
//                }
            }
            
            VStack(){
                ExploreSearchView()
                        .offset(y: 10)
                Spacer()
                ExploreCreateGroupView(
                    groupList: $groupList,
                    screenLock: $screenLock,
                    profiles: $profiles,
                    currentUserEventSelection: $currentUserEventSelection,
                    tempEventSelection: $tempEventSelection,
                    selectedEventType: $selectedEventType
                )
                    .offset(y: userData.createGroupMenuOffset)
            }
            .animation(.spring())
        }
//        .background(setBackgroundColor())
//        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var pageIndex = 0 // Note: it must be static
    @State static var groupList = appUserData // Note: it must be static
    
    static var previews: some View {
//        ForEach(["iPhone SE (2nd generation)", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            let userData = UserData()
            return ExploreView(
                items: Array(appUserData.prefix(4)),
                pageIndex: $pageIndex,
                groupList: $groupList
            )
//            .previewDevice(PreviewDevice(rawValue: deviceName))
//            .previewDisplayName(deviceName)
            .environmentObject(userData)
//        }
    }
}
