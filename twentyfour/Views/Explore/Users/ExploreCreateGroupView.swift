//
//  ExploreCreateGroupView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 01.05.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreCreateGroupView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData = SearchDataContainer()
    
    // Müssen mit übergeben werden
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var tmpTitleString: String
    @Binding var tmpLocationString: String
    @Binding var tmpTimeString: String
    @Binding var tmpMeetingString: String
    
    @State var showCard: Bool = false
    
    // Muss nicht übergeben werden
    @Binding var showProfile: Bool
    
        
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("Sea"),
                    .blue,
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
        
        if groupList.count == 0  {
//            isMenuCollapsed = true
//            isMenuMinimized = false
//            userData.createGroupMenuOffsetY = menuCollapsed
            userData.buttonBarOffset = CGFloat (0)
            resetGroupValues()
        }
    }
    
    func resetGroupValues() {
        selectedEventType = nil
        tmpTitleString = ""
        tmpTimeString = ""
        tmpMeetingString = ""
        tmpLocationString = ""
    }
    
    func isEventTypeAvailable(eventType: EventType) -> Bool {
        
        if !searchData.eventTypes.contains(eventType){
                return false
        }
        
        for profile in groupList {
            if !profile.searchTypes.contains(eventType) {
                return false
            }
        }
        
        return true
    }
    
    func isScrollable() -> Axis.Set {
        if self.groupList.count > 3 {
            return [.vertical]
        }
        return []
    }
    
    func getScrollViewHeight() -> CGFloat {
//        let additionalHeight = 80*self.groupList.count
        let additionalHeight = 80
        return CGFloat(additionalHeight)
    }
    
    var body: some View {
//                NavigationView {
        GeometryReader { geometry in
            
            VStack() {
                Spacer()
                    
                .padding(.top, 10)
                //END:  Buttons on top of menu
                // Komplettes Menü
                    VStack() {
                        Divider()
                        // Headline ausgewähle User
                        HStack(){
//                            Spacer()
                            VStack(){
                                Text("Ausgewähle Personen")
                                        .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                            }

                            Spacer()

                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 10)
                        
                        
                        
                    //END: Headline ausgewählte USer
                            // ScrollView
                        ScrollView(.horizontal){
                            VStack(){
                                Spacer()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                HStack(){
                                    ForEach(self.groupList, id: \.self) { profile in
                                        VStack(){
                                        HStack(){
                                            Button(action: {
                                                self.removeFromGroupList(profile: profile)
//                                                self.showCard.toggle()
                                            }) {
                                                VStack() {
                                                    profile.image
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(Circle())
                                                        .frame(width: 66 ,height: 66)
                                                        .shadow(radius: 4, y: 2)

                                                    Text(profile.username)
                                                        .font(.avenirNextRegular(size: 12))
                                                        .fontWeight(.semibold)
//                                                        .frame(width: 118)
                                                    }
                                                    .foregroundColor(Color ("button1"))
                                            }

                                        }
                                            .sheet(isPresented: self.$showCard) {
                                            UserDetailsViewer(
                                                user: profile,
                                                showCard: self.$showCard
                                            )
                                        }
                                        .animation(nil)
                                        }
                                    .animation(nil)
                                        //END: Zeilen Element pro ausgewähltem User

                                    }
                                }
                                }
//                                .frame(height: self.getScrollViewHeight())
                            .frame(maxWidth: .infinity)
//                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                                .animation(nil)
                        }
                        .frame(maxWidth: .infinity)
                        .animation(nil)
//                        .padding(.top, 10)
                        //END: ScrollView
                        
                        Divider()
                        
                        // Headline EventType
                        HStack(){
//                            Spacer()
                            VStack(alignment: .leading) {
//                                Spacer()
                                Text("Wähle eine Aktivität für die Gruppe")
                                .font(.avenirNextRegular(size: 14))
                                .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                            }

                            Spacer()

                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 10)
                        // END: Headline EventType
                        
                        // Selection EventType
                        HStack() {
                            if self.isEventTypeAvailable(eventType: .food) {
                                EventTypeSelectorButton(
                                    searchData: self.searchData,
                                    eventType: .food,
                                    imageString: "essen",
                                    buttonTextString: "Essen und Trinken",
                                    selectedEventType: self.$selectedEventType,
                                    groupList: self.$groupList
                                )
                            }

                            if self.isEventTypeAvailable(eventType: .activity) {
                                EventTypeSelectorButton(
                                    searchData: self.searchData,
                                    eventType: .activity,
                                    imageString: "freizeit2",
                                    buttonTextString: "Freizeit",
                                    selectedEventType: self.$selectedEventType,
                                    groupList: self.$groupList
                                )
                            }

                            if self.isEventTypeAvailable(eventType: .sport) {
                                EventTypeSelectorButton(
                                    searchData: self.searchData,
                                    eventType: .sport,
                                    imageString: "essen",
                                    buttonTextString: "Sport",
                                    selectedEventType: self.$selectedEventType,
                                    groupList: self.$groupList
                                )
                            }

                        }
                        .padding(.top, 10)

                    }
                        .background(Color .clear)
                    .cornerRadius(10)
                //END: Komplettes Menu
                }
                .edgesIgnoringSafeArea(.bottom)
        }
//    }
    }
    
}

struct EventTypeSelectorButton: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchDataContainer
    
    let eventType: EventType
    let imageString: String
    let buttonTextString: String
    
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    
    var gradientSelected: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color .black.opacity(0.6), Color .black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var gradientNotSelected: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color .black.opacity(0.0), Color .black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    func setSelectedEventType(eventType: EventType) {
        if selectedEventType != eventType {
            selectedEventType = eventType
        } else {
            selectedEventType = nil
        }
        
    }
    
    func isEventTypeAvailable(eventType: EventType) -> Bool {
        // TODO
        if !searchData.eventTypes.contains(eventType){
//        if !userData.currentUser.searchTypes.contains(eventType){
                return false
        }
        
        for profile in groupList {
            if !profile.searchTypes.contains(eventType) {
                return false
            }
        }
        
        return true
    }
    
    var body: some View {
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.setSelectedEventType(eventType: self.eventType)
                }
            }) {
                VStack(){
                    Image(imageString)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 118 ,height:90)
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                        .shadow(radius: 4, y: 2)

                    Text(buttonTextString)
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                        .frame(width: 118)
//                        .foregroundColor(.black)
                        .lineLimit(2)
                }
            }.animation(nil)
            .foregroundColor(Color ("button1"))
                .disabled(!isEventTypeAvailable(eventType: eventType))
//        .opacity(isEventTypeAvailable(eventType: eventType) ? 1.0 : 0.3)
                .saturation(selectedEventType == eventType ? 1.0 : 0.0)
                .buttonStyle(BorderlessButtonStyle())
    }
}


struct HeaderSectionView: View {
    
    @EnvironmentObject var userData: UserData
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var tmpTitleString: String
    @Binding var tmpLocationString: String
    @Binding var tmpTimeString: String
    @Binding var tmpMeetingString: String

        
        func deleteGroupList() {
            groupList.removeAll()
            resetGroupValues()
            
            if groupList.count != 0 {
//                isMenuCollapsed = false
//                isMenuMinimized = true
    //            userData.createGroupMenuOffsetY = menuMinimized3
                userData.buttonBarOffset = CGFloat (100)
//                screenLock = true
            } else {
//                isMenuCollapsed = true
//                isMenuMinimized = false
    //            userData.createGroupMenuOffsetY = menuCollapsed
                userData.buttonBarOffset = CGFloat (0)
//                screenLock = false
            }
        }
        
        func resetGroupValues() {
            selectedEventType = nil
            tmpTitleString = ""
            tmpTimeString = ""
            tmpMeetingString = ""
            tmpLocationString = ""
        }
    
    
    var body: some View {
//        NavigationView {
        ZStack() {
            HStack(){
                Button(action: {
                    self.deleteGroupList()
                }) {
                    HStack(){
                        Text("Verwerfen")
                            .font(.avenirNextRegular(size: 16))
                            .fontWeight(.semibold)
                    }
                        .foregroundColor(Color ("button1"))
                }

                Spacer()

                if self.selectedEventType != nil && self.groupList.count != 0 {
                    VStack {
                        NavigationLink(
                            destination: ExploreCreateNewGroupView(
                                selectedEventType: self.$selectedEventType,
                                groupList: self.$groupList,
                                tmpTitleString: self.$tmpTitleString,
                                tmpLocationString: self.$tmpLocationString,
                                tmpTimeString: self.$tmpTimeString,
                                tmpMeetingString: self.$tmpMeetingString)

                        ) {
                            HStack(){
                           Text("Weiter")
                               .font(.avenirNextRegular(size: 16))
                               .fontWeight(.semibold)
                           Image(systemName: "arrow.right")
                               .font(.system(size: 20, weight: .medium))
                               .frame(width: 20, height: 20)
                           }
                        }
                        .foregroundColor(Color ("button1"))
                        .disabled(self.selectedEventType == nil || self.groupList.count == 0)
                    }
                }
            }
            .padding(.horizontal, 10)
//            .padding(.top, 12)
            HStack(){
                Spacer()
                Text("Neue Gruppe")
                .font(.avenirNextRegular(size: 17))
                    .fontWeight(.medium)
                Spacer()
            }
        }
//                .navigationBarHidden(true)
//                .navigationBarTitle("", displayMode: .inline)
//                .navigationBarBackButtonHidden(true)
//        }
    }
}
