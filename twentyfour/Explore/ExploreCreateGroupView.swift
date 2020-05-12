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
    
    @State var collapsedOffset: Int = 290
    
    @Binding var groupList: [Profile]
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
        groupList.removeAll()
        resetGroupValues()
        
        if groupList.count != 0 {
            userData.createGroupMenuOffsetY = CGFloat (0)
            userData.buttonBarOffset = CGFloat (100)
            screenLock = true
        } else {
            userData.createGroupMenuOffsetY = CGFloat (555)
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
        }
    }
    
    func addTilteAndDescription() {
        userData.createGroupMenuOffsetX = CGFloat (-UIScreen.main.bounds.width)
        userData.addTitleMenuOffsetX = 0
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
        
        if groupList.count == 0  {
            userData.createGroupMenuOffsetY = CGFloat (555)
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
        }
    }
        
    func resetScreenLock() {
        screenLock.toggle()
        userData.createGroupMenuOffsetY = CGFloat (collapsedOffset)
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
        
    func enlargeScreenLock() {
        screenLock.toggle()
        userData.createGroupMenuOffsetY = CGFloat (35)
    }
    
    func isEventTypeAvailable(eventType: EventType) -> Bool {
        
        if !userData.currentUser.searchTypes.contains(eventType){
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
            
            VStack() {
                Spacer()


                if groupList.count != 0 && screenLock {
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
                
                ZStack() {
                    
                    VStack() {

                        HStack(){
                                
                            Text("\(groupList.count) User ausgewählt.")
                                    .font(.avenirNextRegular(size: 20))
                                    .fontWeight(.semibold)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(1)
                                    .padding(.top, 20)
                            
                            Spacer()

                            if userData.createGroupMenuOffsetY == CGFloat (collapsedOffset) {
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.enlargeScreenLock()
                                    }
                                }) {
                                        Image(systemName: "chevron.up")
                                            .font(.avenirNextRegular(size: 20))
                                            .frame(width: 40 ,height:40)
                                            .background(gradient)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                }
                                .padding(.top, 20)
                            } else {
                                    Button(action: {
                                        withAnimation(.linear(duration: 0.2)) {
                                            self.resetScreenLock()
                                        }
                                    }) {
                                            Image(systemName: "chevron.down")
                                                .font(.avenirNextRegular(size: 20))
                                                .frame(width: 40 ,height:40)
                                                .background(gradient)
                                                .foregroundColor(.white)
                                                .clipShape(Circle())
                                    }
                                    .padding(.top, 20)
                                }
                                
                                Button(action: {
                                    self.deleteGroupList()
                                }) {
                                    Image(systemName: "trash")
                                        .font(.avenirNextRegular(size: 16))
                                        .frame(width: 40 ,height:40)
                                        .background(gradientColorPrimary)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                                .padding(.top, 20)

                        }
                        .padding([.leading, .trailing], 20)
                        
                        HStack(){
                                                    
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 0) {
                                        if groupList.count != 0 {
                                            ForEach(groupList, id: \.self) { profile in
                                                ZStack() {

                                                    Button(action: {
                                                        self.removeFromGroupList(profile: profile)
                                                    }) {
                                                    profile.image
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 80 ,height:80)
                                                        .clipShape(Circle())
                                                        .padding(.leading, 10)
                                                    }
                                                    VStack() {
                                                        Spacer()
                                                        HStack() {
                                                            Spacer()

                                                            Button(action: {
                                                                self.removeFromGroupList(profile: profile)
                                                            }) {
                                                                Image(systemName: "xmark")
                                                                    .font(.avenirNextRegular(size: 13))
                                                                    .frame(width: 25 ,height:25)
//                                                                    .background(self.gradient)
                                                                    .background(Color .gray)
                                                                    .foregroundColor(.white)
                                                                    .clipShape(Circle())
                                                            }
                                                            .offset(x: 10, y: 0)
                                                        }
                                                    }
                                                    .frame(width: 80 ,height:80)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                .padding(.bottom, 20)
                                .padding(.leading, 10)
                        }
                        
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
                                selectedEventType: $selectedEventType,
                                groupList: $groupList
                            )
                            
                            EventTypeSelectorButton(
                                eventType: .activity,
                                imageString: "freizeit2",
                                buttonTextString: "Freizeit",
                                selectedEventType: $selectedEventType,
                                groupList: $groupList
                            )
                            
                            EventTypeSelectorButton(
                                eventType: .sport,
                                imageString: "sport",
                                buttonTextString: "Sport",
                                selectedEventType: $selectedEventType,
                                groupList: $groupList
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
                            .disabled(selectedEventType == nil || groupList.count == 0)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)

                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.bottom, 30)
                    .background(Color .white)
//                    .transition(.move(edge: .top))
                    .cornerRadius(15)
                    .shadow(radius: 30, y: 10)
                }
            }
    }
    
}

struct ExploreCreateGroupView_Previews: PreviewProvider {
        @State static var pageIndex = 0 // Note: it must be static
        @State static var screenLock = false // Note: it must be static
        @State static var groupList = appUserData // Note: it must be static
        @State static var selectedEventType: EventType? = EventType.food // Note: it must be static
        
        static var previews: some View {
                let userData = UserData()
                return ExploreCreateGroupView(
                    groupList: $groupList,
                    screenLock: $screenLock,
                    selectedEventType: $selectedEventType
                )
                .environmentObject(userData)
        }
    }

struct EventTypeSelectorButton: View {
    
    @EnvironmentObject var userData: UserData
    
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
        
        if !userData.currentUser.searchTypes.contains(eventType){
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
                        .cornerRadius(11)
                        .shadow(radius: 5, x: 0, y: 2)
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
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.semibold)
                        .frame(width: 118)
                        .lineLimit(2)
                }
            }
        .disabled(!isEventTypeAvailable(eventType: eventType))
        .opacity(isEventTypeAvailable(eventType: eventType) ? 1.0 : 0.3)
        .buttonStyle(ListButtonStyle())
    }
}
