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
    
    @State var collapsedOffset: CGFloat = 290
    
    @Binding var screenLock: Bool
    @Binding var selectedEventType: EventType?

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
        userData.groupList.removeAll()
        resetGroupValues()
        
        if userData.groupList.count != 0 {
            userData.createGroupMenuOffsetY = menuMinimized3
            userData.buttonBarOffset = CGFloat (100)
            screenLock = true
        } else {
            userData.createGroupMenuOffsetY = menuCollapsed
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
        }
    }
    
    func addTilteAndDescription() {
        userData.createGroupMenuOffsetX = menuLeftOut
        userData.addTitleMenuOffsetX = menuIn
    }
    
    func removeFromGroupList(profile: Profile) {
        if userData.groupList.contains(profile) {
            userData.groupList.remove(at: userData.groupList.firstIndex(of: profile)!)
        }
        
        if userData.groupList.count == 0  {
            userData.createGroupMenuOffsetY = menuCollapsed
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
            resetGroupValues()
        }
    }
        
    func resetScreenLock() {
        screenLock.toggle()
        userData.createGroupMenuOffsetY = menuMinimized3
        print(userData.groupList.count)
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
        
    func enlargeScreenLock() {
        screenLock.toggle()
        userData.createGroupMenuOffsetY = menuExpanded
        print(userData.groupList.count)
    }
    
    func isEventTypeAvailable(eventType: EventType) -> Bool {
        
        if !userData.currentUser.searchTypes.contains(eventType){
                return false
        }
        
        for profile in userData.groupList {
            if !profile.searchTypes.contains(eventType) {
                return false
            }
        }
        
        return true
    }
    
    var body: some View {
            
            VStack() {
                Spacer()

                if userData.groupList.count != 0 && screenLock {
                        Button(action: {
                                self.resetScreenLock()
                        }) {
                            VStack(){
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .font(.avenirNextRegular(size: 42))
                                    .padding(.vertical, 10.0)
                                    .padding(.top, 20)
                                    .foregroundColor(.white)
                                Text("Weiter stöbern")
                                    .font(.avenirNextRegular(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .animation(.spring())
                    }
                
                    VStack() {
                            HStack(){
                                Text("\(userData.groupList.count) User ausgewählt.")
                                        .font(.avenirNextRegular(size: 20))
                                        .fontWeight(.semibold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                                
                                Spacer()

                                if userData.createGroupMenuOffsetY == menuMinimized3 {
                                    Button(action: {
                                        withAnimation(.linear(duration: 0.2)) {
                                            self.enlargeScreenLock()
                                        }
                                    }) {
                                            Image(systemName: "chevron.up")
                                                .font(.avenirNextRegular(size: 20))
                                                .frame(width: 40 ,height:40)
                                                .background(gradientSeaAndBlue)
                                                .foregroundColor(.white)
                                                .clipShape(Circle())
                                    }
                                } else {
                                        Button(action: {
                                            withAnimation(.linear(duration: 0.2)) {
                                                self.resetScreenLock()
                                            }
                                        }) {
                                                Image(systemName: "chevron.down")
                                                    .font(.avenirNextRegular(size: 20))
                                                    .frame(width: 40 ,height:40)
                                                    .background(gradientSeaAndBlue)
                                                    .foregroundColor(.white)
                                                    .clipShape(Circle())
                                        }
                                    }
                                    
                                    Button(action: {
                                        self.deleteGroupList()
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.avenirNextRegular(size: 16))
                                            .frame(width: 40 ,height:40)
//                                            .background(gradientColorPrimary)
                                            .background(Color .black)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                    }

                            }
                            .padding(.top, 20)
                            .padding([.leading, .trailing], 20)
                        
//                        VStack(alignment: .leading) {
//                        HStack() {
                            HStack() {
                                if userData.groupList.count != 0 {
                                    ForEach(userData.groupList, id: \.self) { profile in
                                                Button(action: {
                                                    self.removeFromGroupList(profile: profile)
                                                }) {
                                                profile.image
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
    //                                                        .padding(.leading, 10)
                                                    .frame(width: 80 ,height:80)
                                                }
                                        
//                                        }
                                        }
                                    }
                                Spacer()
                                }
                                .padding(.leading, 20)
                                .padding(.bottom, 20)
//                            }
//                            }
                        .zIndex(0)
                        
                        HStack(){
                            VStack(alignment: .leading) {
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
                        
                        
                        HStack() {


                            EventTypeSelectorButton(
                                eventType: .food,
                                imageString: "essen",
                                buttonTextString: "Essen und Trinken",
                                selectedEventType: $selectedEventType
//                                groupList: $groupList
                            )

                            EventTypeSelectorButton(
                                eventType: .activity,
                                imageString: "freizeit2",
                                buttonTextString: "Freizeit",
                                selectedEventType: $selectedEventType
//                                groupList: $groupList
                            )

                            EventTypeSelectorButton(
                                eventType: .sport,
                                imageString: "essen",
                                buttonTextString: "Sport",
                                selectedEventType: $selectedEventType
//                                groupList: $groupList
                            )

                        }
                        .padding(.bottom, 20)
                        
                        HStack(){
                            Spacer()
                            Button(action: {
                                self.addTilteAndDescription()
                            }) {
                                Text("weiter")
                                .font(.avenirNextRegular(size: 18))
                                .fontWeight(.semibold)
                            }
                            .disabled(selectedEventType == nil || userData.groupList.count == 0)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)
                        .background(Color .white)

                    }
//                    .padding(.bottom, 30)
                    .background(Color .white)
                    .cornerRadius(10)
                }
                .edgesIgnoringSafeArea(.bottom)
//            }
    }
    
}

struct ExploreCreateGroupView_Previews: PreviewProvider {
        @State static var pageIndex = 0 // Note: it must be static
        @State static var screenLock = false // Note: it must be static
//        @State static var groupList = appUserData // Note: it must be static
        @State static var selectedEventType: EventType? = EventType.food // Note: it must be static
        
        static var previews: some View {
                let userData = UserData()
                return ExploreCreateGroupView(
//                    groupList: $groupList,
                    screenLock: $screenLock,
                    selectedEventType: $selectedEventType
                )
                .environmentObject(userData)
        }
    }

struct EventTypeSelectorButton: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData = SearchData()
    
    let eventType: EventType
    let imageString: String
    let buttonTextString: String
    
    @Binding var selectedEventType: EventType?
//    @Binding var groupList: [Profile]
    
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
        if !searchData.selectedEventTypes.contains(eventType){
//        if !userData.currentUser.searchTypes.contains(eventType){
                return false
        }
        
        for profile in userData.groupList {
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
//                        .cornerRadius(11)
                        .overlay(
                            VStack() {
                                Spacer()
                                HStack() {
                                    Spacer()
                                    if selectedEventType == eventType {

                                        Image(systemName: "checkmark")
                                            .font(.avenirNextRegular(size: 16))
                                            .frame(width: 30 ,height:30)
                                            .background(gradientColorPrimary)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                            .padding(10)
                                    }
                                }
                            }
                        )

                    Text(buttonTextString)
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                        .frame(width: 118)
                        .foregroundColor(.black)
                        .lineLimit(2)
                }
            }
        .disabled(!isEventTypeAvailable(eventType: eventType))
        .opacity(isEventTypeAvailable(eventType: eventType) ? 1.0 : 0.3)
//        .buttonStyle(ListButtonStyle())
    }
}
