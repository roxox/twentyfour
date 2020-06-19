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
    @ObservedObject var searchDataContainer: SearchDataContainer
    
    var items: [Profile]
    @Binding var pageIndex_old: Int
//    @Binding var groupList: [Profile]
    @Binding var pageIndex: Int
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var showingMenu = false
    @State var activateGroup = false
    @State var showButtons = false
    @State var menuOffset = CGFloat (555)
//    @State var requets: [Profile] = []
    @State var screenLock: Bool = true
    @State var profiles: [Profile] = appUserData
    @State var currentUserEventSelection: [EventType] = [.food, .activity]
    @State var tempEventSelection: [EventType] = [.food, .sport, .activity]
    @State var selectedEventType: EventType?
    @State private var currentPage = 0
    @State var lockScreenIndex = 0
    @State var mainScreenIndex = 1
    @State var createGroupScreenIndex = 2
    
    @State var remainingTime: Int = 0
    @State var localTargetTime: Date = Date()
    @State var localCurrentTime: Date = Date()
    @State var localCreatedTime: Date = Date()
    @State var groupList: [Profile] = []
    
    @State var isMenuCollapsed: Bool = true
    @State var isMenuMinimized: Bool = false
        
    @State var offset: CGFloat = 0
    @State var showProfile = false
    
//    func addAppUserToRequests(appUser: Profile) {
//        requets.append(appUser)
//    }
    
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
        return 0.5
    }
    
    func setMainScreen() -> Double {
        if userData.groupList.count != 0 && screenLock {
            return 0
        } else {
            return 1
        }
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
        
        ZStack() {
            VStack(){
//            ScrollView(.vertical, showsIndicators: false) {

//                Rectangle().fill(Color .clear)
//                    .frame(height: 35)

                VStack() {
                    if pageIndex_old == 0 {
                        Spacer()

                        if self.searchDataContainer.targetDate > self.searchDataContainer.currentTime {
                            ExploreProfileView(
                                searchDataContainer: searchDataContainer,
                                screenLock: $screenLock,
                                profiles: $profiles,
                                currentUserEventSelection: $currentUserEventSelection,
                                tempEventSelection: $tempEventSelection,
                                selectedEventType: $selectedEventType,
                                groupList: $groupList,
                                isMenuMinimized: $isMenuMinimized,
                                isMenuCollapsed: $isMenuCollapsed,
                                showProfile: $showProfile
                            )
                        }
//                        else {
//                            ExploreNoSearchView()
//                        }

                        if remainingTime < 3600 {

                            if secondsToHours(seconds: remainingTime) == 0 && secondsToMinutes(seconds: remainingTime) != 0{
                                Text("Aktiv für die nächsten \(secondsToMinutes(seconds: remainingTime)) Minuten")
                                        .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.semibold)
                                        .foreground(gradientPinkBlueAccent)
                            } else {
                            Text("Suche noch aktiv für die nächsten \(secondsToSeconds(seconds: remainingTime)) Sekunden")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.semibold)
                                    .foreground(gradientPinkBlueAccent)
                            }
                            }
                        }
                        Spacer()

                }
                .animation(.spring())
                }
//            }
//            .background(Color .white)

            VStack() {
                ExploreSearchButtonView(
                    searchDataContainer: searchDataContainer)
                    .offset(y: 10)

                Spacer()
            }

            if !self.isMenuCollapsed && !self.isMenuMinimized {
                Color .black.opacity(setOpacity())
                    .edgesIgnoringSafeArea(.all)
                BlurView(style: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isMenuMinimized = true
                    }
            }

            VStack(){

                Spacer()

                ZStack() {
                    VStack(){

                        Spacer()

                        ExploreCreateGroupView(
                            screenLock: $screenLock,
                            selectedEventType: $selectedEventType,
                            groupList: $groupList,
                            isMenuMinimized: $isMenuMinimized,
                            isMenuCollapsed: $isMenuCollapsed,
                            showProfile: $showProfile
                        )
//                            .offset(x: userData.createGroupMenuOffsetX, y: userData.createGroupMenuOffsetY + self.offset)
                            .offset(y: (self.isMenuCollapsed ? menuCollapsed : self.isMenuMinimized ? menuMinimized3 + CGFloat((groupList.count-1) * 78) : menuExpanded) + self.offset)
                            .shadow(radius: 10)

                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if !self.isMenuMinimized && !self.isMenuCollapsed {
                                        if gesture.translation.height > 0 {
                                            self.offset = gesture.translation.height * 1.3
                                        }
                                    } else if !self.isMenuCollapsed && self.isMenuMinimized {

                                        if gesture.translation.height < 0 {
                                            self.offset = gesture.translation.height
                                        }
                                    }
                                }

                                .onEnded { _ in
                                    if self.offset > menuMinimized3/2 {
                                        self.isMenuMinimized = true
                                        self.isMenuCollapsed = false
                                    } else {
                                        self.isMenuMinimized = false
                                        self.isMenuCollapsed = false

                                    }
                                    self.offset = CGFloat(0)
//                                    if abs(self.offset.width) > 100 {
//                                        // remove the card
//                                    } else {
//                                        self.offset = .zero
//                                    }
//                                    if self.offset <
                                }
                        )

                    }
//                    ExploreGroupAddTitleView(
//                        pageIndex: $pageIndex,
//                        screenLock: $screenLock,
//                        selectedEventType: $selectedEventType
//                    )
//                        .offset(x: userData.addTitleMenuOffsetX, y: userData.createGroupMenuOffsetY)
                }
            }
            .animation(.spring())
        }
        .onReceive(self.searchDataContainer.targetDateWillChange) { newValue in
            self.localTargetTime = newValue
        }
        .onReceive(self.searchDataContainer.currentTimeWillChange) { newValue in
            self.localCurrentTime = newValue
        }
        .onReceive(self.searchDataContainer.createdDateWillChange) { newValue in
            self.localCreatedTime = newValue
        }
        .onReceive(self.searchDataContainer.remainingTimeWillChange) { newValue in
            self.remainingTime = newValue
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
