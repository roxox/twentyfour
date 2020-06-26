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
    @Binding var isButtonBarHidden: Bool
    @Binding var isSettingsHidden: Bool
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var profiles: [Profile] = appUserData
    @State var selectedEventType: EventType?
    @State private var currentPage = 0
    @State var lockScreenIndex = 0
    @State var mainScreenIndex = 1
    @State var createGroupScreenIndex = 2
    
    @State var tmpTitleString: String = ""
    @State var tmpLocationString: String = ""
    @State var tmpTimeString: String = ""
    @State var tmpMeetingString: String = ""
    
    @State var remainingTime: Int = 0
    @State var localTargetTime: Date = Date()
    @State var localCurrentTime: Date = Date()
    @State var localCreatedTime: Date = Date()
    @State var groupList: [Profile] = []
        
    @State var offset: CGFloat = 0
    @State var showProfile = false
    
//    func addAppUserToRequests(appUser: Profile) {
//        requets.append(appUser)
//    }
    
    
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
        return 0.7
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
                ScrollView(groupList.count == 0 ? [.vertical] : [], showsIndicators: false) {


                VStack() {
                    if pageIndex_old == 0 {
                        Spacer()

                        if self.searchDataContainer.targetDate > self.searchDataContainer.currentTime {
                            ExploreProfileView(
                                searchDataContainer: searchDataContainer,
                                selectedEventType: $selectedEventType,
                                groupList: $groupList,
                                tmpTitleString: self.$tmpTitleString,
                                tmpLocationString: self.$tmpLocationString,
                                tmpTimeString: self.$tmpTimeString,
                                tmpMeetingString: self.$tmpMeetingString,
                                isButtonBarHidden: self.$isButtonBarHidden
                            )

                            if groupList.count == 0 {
                                ExploreGroupView(
                                    searchDataContainer: searchDataContainer,
                                    selectedEventType: $selectedEventType,
                                    groupList: $groupList
                                )
                                .background(Color ("background1"))
//                                .opacity(0.1)
//                                .saturation(0.6)
                            }
                            else {

                                Spacer()
                                ExploreCreateGroupView(
                                    selectedEventType: $selectedEventType,
                                    groupList: $groupList,
                                    tmpTitleString: self.$tmpTitleString,
                                    tmpLocationString: self.$tmpLocationString,
                                    tmpTimeString: self.$tmpTimeString,
                                    tmpMeetingString: self.$tmpMeetingString,
                                    isButtonBarHidden: self.$isButtonBarHidden
                                )
                                .animation(.spring())
                            }
                            
                            if self.searchDataContainer.targetDate - self.searchDataContainer.currentTime < 3600 && self.searchDataContainer.targetDate - self.searchDataContainer.currentTime >= 0 {

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
                        }
                        Spacer()

                }
                .animation(.spring())
                }
//                if groupList.count == 0 {
                Rectangle().fill(Color .clear)
                        .frame(height: 30)
//                }
            }
            
                VStack() {
                    ExploreSearchButtonView(
                        searchDataContainer: searchDataContainer,
                        isSettingsHidden: self.$isSettingsHidden)
                        .offset(y: 10)

                    Spacer()
                }
                .offset(y: groupList.count == 0 ? 0 : -150)
            
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
//        .animation(.spring())
        .edgesIgnoringSafeArea(.bottom)
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
