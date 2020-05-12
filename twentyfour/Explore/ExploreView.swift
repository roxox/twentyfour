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
    @Binding var tabBarIndex: Int
    
    @State var showingMenu = false
    @State var activateGroup = false
    @State var showButtons = false
    @State var menuOffset = CGFloat (555)
    @State var requets: [Profile] = []
    @State var screenLock: Bool = true
    @State var profiles: [Profile] = appUserData
    @State var currentUserEventSelection: [EventType] = [.food, .activity]
    @State var tempEventSelection: [EventType] = [.food, .sport, .activity]
    @State var selectedEventType: EventType?
    @State private var currentPage = 0
    @State var lockScreenIndex = 0
    @State var mainScreenIndex = 1
    @State var createGroupScreenIndex = 2
        
    
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
    
    func setLockScreen() -> Double {
        if groupList.count != 0 && screenLock {
            return 1
        } else {
            return 0
        }
    }
    
    func setMainScreen() -> Double {
        if groupList.count != 0 && screenLock {
            return 0
        } else {
            return 1
        }
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
                    .frame(height: 35)

                        VStack() {
                            if pageIndex == 0 {
                                Spacer()
                                
                                ExploreProfileView(items: appUserData,
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
            .background(Color .white)
//            .zIndex(setMainScreen())

            VStack() {
                
                ExploreSearchButtonView()
                        .offset(y: 10)
                Spacer()
            }

            if groupList.count != 0 && screenLock {
                Rectangle().fill(Color .black.opacity(setOpacity()))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.spring())
    //                .zIndex(setLockScreen())
            }
            
            VStack(){
                
                Spacer()
                
                ZStack() {
                    ExploreCreateGroupView(
                        groupList: $groupList,
                        screenLock: $screenLock,
                        selectedEventType: $selectedEventType
                    )
                        .frame(width: UIScreen.main.bounds.width)
                        .offset(x: userData.createGroupMenuOffsetX, y: userData.createGroupMenuOffsetY)
                    
                    ExploreGroupAddTitleView(
                        tabBarIndex: $tabBarIndex,
                        groupList: $groupList,
                        screenLock: $screenLock,
                        selectedEventType: $selectedEventType
                    )
                        .frame(width: UIScreen.main.bounds.width)
                        .offset(x: userData.addTitleMenuOffsetX, y: userData.createGroupMenuOffsetY)
                }
                
            }
            .animation(.spring())
//            .zIndex(Double(createGroupScreenIndex))
            
            
        }
//        .background(setBackgroundColor())
//        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct ExploreView_Previews: PreviewProvider {
    @State static var pageIndex = 0 // Note: it must be static
    @State static var tabBarIndex = 0 // Note: it must be static
    @State static var groupList = appUserData // Note: it must be static
    
    static var previews: some View {
//        ForEach(["iPhone SE (2nd generation)", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            let userData = UserData()
            return ExploreView(
                items: Array(appUserData.prefix(4)),
                pageIndex: $pageIndex,
                groupList: $groupList,
                tabBarIndex: $tabBarIndex
            )
//            .previewDevice(PreviewDevice(rawValue: deviceName))
//            .previewDisplayName(deviceName)
            .environmentObject(userData)
//        }
    }
}
