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
    @Binding var screenLock: Bool
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var isMenuMinimized: Bool
    @Binding var isMenuCollapsed: Bool
    
    @State var tmpTitleString: String = ""
    @State var tmpLocationString: String = ""
    @State var tmpTimeString: String = ""
    @State var tmpMeetingString: String = ""
    
    @State var showCard: Bool = false
    
    // Muss nicht übergeben werden
    @Binding var showProfile: Bool
    

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
    
    func deleteGroupList() {
        groupList.removeAll()
        resetGroupValues()
        
        if groupList.count != 0 {
            isMenuCollapsed = false
            isMenuMinimized = true
//            userData.createGroupMenuOffsetY = menuMinimized3
            userData.buttonBarOffset = CGFloat (100)
            screenLock = true
        } else {
            isMenuCollapsed = true
            isMenuMinimized = false
//            userData.createGroupMenuOffsetY = menuCollapsed
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
        }
    }
    
    func hideOrShowMenu() {
        if isMenuMinimized {
            showMenu()
        } else {
            hideMenu()
        }
    }
    
    func hideMenu() {
        isMenuMinimized = true
    }
    
    func showMenu() {
        isMenuMinimized = false
    }

    
    func addTilteAndDescription() {
        userData.createGroupMenuOffsetX = menuLeftOut
        userData.addTitleMenuOffsetX = menuIn
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
        
        if groupList.count == 0  {
            isMenuCollapsed = true
            isMenuMinimized = false
//            userData.createGroupMenuOffsetY = menuCollapsed
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
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
        let additionalHeight = 80*self.groupList.count
//        userData.createGroupMenuOffsetY = menuMinimized3 + CGFloat(additionalHeight)
        return CGFloat(additionalHeight)
//        if self.groupList.count == 0 {
//            return CGFloat(0)
//        }
//        else if self.groupList.count == 1 {
//            return CGFloat(120)
//        }
//        else if self.groupList.count == 2 {
//            return CGFloat(180)
//        }
//        return CGFloat(210)
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack() {
                Spacer()

                                    
                // Buttons on top of menu
                HStack(){
                        Spacer()
                            if self.isMenuMinimized {
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.hideOrShowMenu()
                                    }
                                }) {
                                HStack() {
                                    Image(systemName: "chevron.compact.up")
                                        .font(.system(size: 20, weight: .medium))
                                        .frame(width: 40, height: 40)
                                    
                                }
                                .background(Color ("background1_inverted"))
                                .foregroundColor(Color ("button1_inverted"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            } else {
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.hideOrShowMenu()
                                    }
                                }) {
                                    
                                    Text("weitere User hinzufügen")
                                        .font(.avenirNextRegular(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color .white)
                                    .padding(8)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                                        
                                    }
                                    .padding(.bottom, 10)
                            }
                    Spacer()
                }
                .padding(.top, 10)
                //END:  Buttons on top of menu
                // Komplettes Menü
                    VStack() {
                        HStack(){
                            Button(action: {
                                self.deleteGroupList()
                            }) {
                                HStack(){
                                    Image(systemName: "xmark")
                                        .font(.system(size: 20, weight: .medium))
                                        .frame(width: 36, height: 36)
//                                        .padding(.leading, 10)
                                    Text("Verwerfen")
                                        .font(.avenirNextRegular(size: 16))
                                        .fontWeight(.semibold)
//                                        .padding(.trailing, 20)
                                }
                                    .foregroundColor(Color ("button1"))
                            }
                            
                            Spacer()
                            
                            if self.selectedEventType != nil && self.groupList.count != 0 {
                                VStack {
                                    NavigationLink(
                                        destination: ExploreCreateNewGroupView(
                                            screenLock: self.$screenLock,
                                            selectedEventType: self.$selectedEventType,
                                            groupList: self.$groupList,
                                            isMenuMinimized: self.$isMenuMinimized,
                                            isMenuCollapsed: self.$isMenuCollapsed,
                                            tmpTitleString: self.$tmpTitleString,
                                            tmpLocationString: self.$tmpLocationString,
                                            tmpTimeString: self.$tmpTimeString,
                                            tmpMeetingString: self.$tmpMeetingString)
                                        
                                    ) {
                                        HStack(){
                                       Text("Weiter")
                                           .font(.avenirNextRegular(size: 16))
                                           .fontWeight(.semibold)
//                                           .padding(.trailing, 20)
                                       Image(systemName: "arrow.right")
                                           .font(.system(size: 20, weight: .medium))
                                           .frame(width: 36, height: 36)
                                       }
                                    }
                                    .foregroundColor(Color ("button1"))
                                    .disabled(self.selectedEventType == nil || self.groupList.count == 0)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        
                        // Headline ausgewähle User
                        HStack(){
                            Spacer()
                            VStack(){
                                Text("\(self.groupList.count) User ausgewählt")
                                        .font(.avenirNextRegular(size: 20))
                                        .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                            }

                            Spacer()

                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 20)
                    //END: Headline ausgewählte USer
                            // ScrollView
                        HStack(){
//                            ScrollView(self.isScrollable(), showsIndicators: false) {
                            VStack(){
                                Spacer()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    ForEach(self.groupList, id: \.self) { profile in
                                        VStack(){
//                                        Text("Count: \(self.groupList.count)")
                                       // Zeilen Element pro ausgewähltem User
                                        HStack(){
                                            Button(action: {
                                                self.showCard.toggle()
                                            }) {
                                                profile.image
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
                                                    .frame(width: 66 ,height: 66)
                                                }
                                                .padding(.trailing, 10)
                                                
                                                VStack(alignment: .leading){
                                                    Text(profile.username)
//                                                    .font(.avenirNextRegular(size: 20))
                                                    .font(.avenirNextRegular(size: 16))
                                                    .fontWeight(.semibold)
                                                    
//                                                    Text("Los Angeles")
                                                    Text(profile.searchParameter.locationName)
                                                    .font(.avenirNextRegular(size: 14))
                                                    .fontWeight(.light)

                                                    Text("Essen und Trinken, Freizeit, Sport")
                                                    .font(.avenirNextRegular(size: 14))
                                                    .fontWeight(.light)
                                                    
                                                    Spacer()
                                            }

                                            VStack(){
                                            // SearchButton
                                            Button(action: {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    self.removeFromGroupList(profile: profile)
                                                }
                                            }) {
                                                HStack() {
                                                    Image(systemName: "xmark")
                                                        .font(.system(size: 22, weight: .medium))
                                                        .foregroundColor(Color ("button1"))
//                                                        .foregroundColor(.black)
                                                        .fixedSize()
                                                        .frame(width: 45, height: 45)
//                                                        .background(Color .clear)
//                                                        .clipShape(Circle())
                                                }
                                                .padding(.leading, 10)
                                                }
                                                Spacer()
                                            }
//                                            Spacer()
                                            
                                        }
                                            .sheet(isPresented: self.$showCard) {
                                            UserDetailsViewer(
                                                user: profile,
                                                showCard: self.$showCard
                                            )
                                        }
                                        .animation(nil)
                                        .padding(.horizontal, 20)
//                                        .frame(height: self.getScrollViewHeight())
//                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        }
                                    .animation(nil)
                                        //END: Zeilen Element pro ausgewähltem User
                                        
                                    }
//                                }
                                }
                                .frame(height: self.getScrollViewHeight())
                                .frame(width: UIScreen.main.bounds.width)
//                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                                .animation(nil)
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .animation(nil)
                        .padding(.top, 10)
                        //END: ScrollView
                        
                        Divider()
                        
                        // Headline EventType
                        HStack(){
                            Spacer()
                            VStack(alignment: .center) {
//                                Spacer()
                                Text("Wähle eine Aktivität für die Gruppe")
                                        .font(.avenirNextRegular(size: 20))
                                        .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                                Text("Basierend auf der Auswahl aller Teilnehmer")
                                        .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.light)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                            }

                            Spacer()

                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 20)
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
    //                                groupList: $groupList
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
    //                                groupList: $groupList
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
    //                                groupList: $groupList
                                )
                            }

                        }
                        .padding(.top, 10)
                        .padding(.bottom, 23)

                    }
                    .background(Color ("background1"))
                    .cornerRadius(10)
                //END: Komplettes Menu
                }
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
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

                    Text(buttonTextString)
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                        .frame(width: 118)
//                        .foregroundColor(.black)
                        .lineLimit(2)
                }
            }.animation(nil)
        .disabled(!isEventTypeAvailable(eventType: eventType))
//        .opacity(isEventTypeAvailable(eventType: eventType) ? 1.0 : 0.3)
                .saturation(selectedEventType == eventType ? 1.0 : 0.0)
                .buttonStyle(BorderlessButtonStyle())
    }
}
