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
    @Binding var pageIndex_old: Int
//    @Binding var groupList: [Profile]
    @Binding var pageIndex: Int
    
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
    
    func resetScreenLock() {
        screenLock.toggle()
//        userData.createGroupMenuOffset = CGFloat (255)
    }
    
    func setBackgroundColor () -> Color {
        if userData.groupList.count == 0 {
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
    
    func setMainScreen() -> Double {
        if userData.groupList.count != 0 && screenLock {
            return 0
        } else {
            return 1
        }
    }
    
    var body: some View {
        ZStack() {
            
            ScrollView(.vertical, showsIndicators: false) {

                Rectangle().fill(Color .clear)
                    .frame(height: 35)

                VStack() {
                    if pageIndex_old == 0 {
                        Spacer()
                        
                        ExploreProfileView(
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

            VStack() {
                ExploreSearchButtonView()
                    .offset(y: 10)
                
                Spacer()
            }

            if userData.groupList.count != 0 && screenLock {
                Color .black.opacity(setOpacity())
                    .edgesIgnoringSafeArea(.all)
//                BlurView(style: .systemMaterial)
//                    .edgesIgnoringSafeArea(.all)
//                Rectangle().fill(Color .black.opacity(setOpacity()))
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .frame(minHeight: 0, maxHeight: .infinity)
//                    .edgesIgnoringSafeArea(.all)
//                    .animation(.spring())
            }
            
            VStack(){
                
                Spacer()
                
                ZStack() {
                    ExploreCreateGroupView(
                        screenLock: $screenLock,
                        selectedEventType: $selectedEventType
                    )
                        .offset(x: userData.createGroupMenuOffsetX, y: userData.createGroupMenuOffsetY)
                    
                    ExploreGroupAddTitleView(
                        pageIndex: $pageIndex,
                        screenLock: $screenLock,
                        selectedEventType: $selectedEventType
                    )
                        .offset(x: userData.addTitleMenuOffsetX, y: userData.createGroupMenuOffsetY)
                }
            }
            .animation(.spring())
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    @State static var pageIndex_old = 0 // Note: it must be static
    @State static var pageIndex = 0 // Note: it must be static
//    @State static var groupList = appUserData // Note: it must be static
    
    static var previews: some View {
            let userData = UserData()
            return ExploreView(
                items: Array(appUserData.prefix(4)),
                pageIndex_old: $pageIndex_old,
                pageIndex: $pageIndex
            )
            .environmentObject(userData)
    }
}
