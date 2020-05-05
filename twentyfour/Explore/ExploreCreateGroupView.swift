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
    @Binding var profiles: [Profile]
    @Binding var currentUserEventSelection: [EventType]
    @Binding var tempEventSelection: [EventType]
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
//                    Color ("Sea"),
//                    Color ("Sea"),
                    .blue,
                    .purple
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    
    var gradientNozSelected: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color .black.opacity(0.0), Color .black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    
    var gradientSelected: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color .black.opacity(0.6), Color .black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    func deleteGroupList() {
//        profiles.append(contentsOf: groupList)
        groupList.removeAll()
        resetGroupValues()
        
        if groupList.count != 0 {
            userData.createGroupMenuOffset = CGFloat (35)
            userData.mainMenuOffset = CGFloat (100)
            screenLock = true
        } else {
            userData.createGroupMenuOffset = CGFloat (455)
            userData.mainMenuOffset = CGFloat (0)
            screenLock = false
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
        
        if groupList.count == 0  {
            userData.createGroupMenuOffset = CGFloat (455)
            userData.mainMenuOffset = CGFloat (0)
            screenLock = false
        }
    }
        
    func resetScreenLock() {
        screenLock.toggle()
        userData.createGroupMenuOffset = CGFloat (collapsedOffset)
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
        
    func enlargeScreenLock() {
        screenLock.toggle()
        userData.createGroupMenuOffset = CGFloat (35)
    }
    
    func isEventTypeAvailable(eventType: EventType) -> Bool {
        
        if !currentUserEventSelection.contains(eventType){
                return false
        }
        
        for profile in groupList {
            if !profile.searchTypes.contains(eventType) {
                return false
            }
        }
        
        return true
    }
    
    func setSelectedEventType(eventType: EventType) {
        selectedEventType = eventType
    }
    
    func updateTempEventSelection(items: [EventType]) {
        for eventType in tempEventSelection {
            if !items.contains(eventType) {
                tempEventSelection.remove(at: tempEventSelection.firstIndex(of: eventType)!)
            }
        }
    }
    
    var body: some View {
            
            VStack() {
                Spacer()


                if groupList.count != 0 && screenLock && profiles.count != 0 {
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
                
                if profiles.count == 0 {
                    VStack(){
                        Spacer()
                        
                         RoundedRectangle(cornerRadius: 19)
                                
                            .stroke(Color.white, lineWidth: 2)
                            .overlay(
                                    
                                    Text("Keine weiteren Treffer")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                    .foreground(Color .white)
                            )
                            
                                .frame(height: 45)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                     
                        Spacer()
                    }
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

                            if userData.createGroupMenuOffset == CGFloat (collapsedOffset) {
                                Button(action: {
                                    self.enlargeScreenLock()
                                }) {
                                    VStack(){
                                        Image(systemName: "chevron.up")
                                            .font(.avenirNextRegular(size: 20))
                                            .frame(width: 40 ,height:40)
                                            .background(gradient)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                            .padding(.top, 20)
                                            .padding(.leading, 10)
                                    }
                                }
                            } else {
                                Button(action: {
                                    self.resetScreenLock()
                                }) {
                                    VStack(){
                                        Image(systemName: "chevron.down")
                                            .font(.avenirNextRegular(size: 20))
                                            .frame(width: 40 ,height:40)
                                            .background(gradient)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                            .padding(.top, 20)
                                            .padding(.leading, 10)
                                    }
                                }
                            }
                            
                            Button(action: {
                                self.deleteGroupList()
                            }) {
                                VStack(){
                                    Image(systemName: "trash")
                                        .font(.avenirNextRegular(size: 16))
                                        .frame(width: 40 ,height:40)
                                        .background(gradientColorPrimary)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .padding(.top, 20)
                                        .padding(.leading, 10)
                                }
                            }

                        }
                        .padding([.leading, .trailing], 20)
                        
                        HStack(){
                                                    
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 0) {
                                        if groupList.count != 0 {
                                            ForEach(groupList, id: \.self) { profile in
                                                VStack() {

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
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                .padding(.bottom, 20)
                                .padding(.leading, 10)
                        }
                        
                        HStack(){
    //                        Spacer()
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
                            
                            

                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.setSelectedEventType(eventType: .food)
                                }
                            }) {
                                VStack(){
                                    Image("pic")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 118 ,height:90)
                                        .cornerRadius(11)
                                        .shadow(radius: 5, x: 0, y: 2)
                                        .overlay(
                                            ZStack(){
                                                RoundedRectangle(cornerRadius: 11)
                                                    .fill(selectedEventType == .food ? gradientSelected : gradientNozSelected)
        //                                            .stroke(gradient, lineWidth: 5)
                                                VStack() {
                                                    Spacer()
                                                    HStack() {
                                                        Spacer()
                                                        if selectedEventType == .food {
                                                        Image(systemName: "checkmark")
                                                            .font(.system(size: 30, weight: .bold))
                                                            .foregroundColor(Color .white.opacity(0.8))
                                                            .padding()
                                                        }
//                                                        Spacer()
                                                    }
//                                                    Spacer()
                                                }
                                            }
                                        )
                                    
                                    Text("Essen und Trinken")
                                        .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.semibold)
                                        .frame(width: 118)
                                        .allowsTightening(true)
                                        .lineLimit(2)
                                }
                            }
                            .disabled(!isEventTypeAvailable(eventType: .food))
                            .buttonStyle(ListButtonStyle())
                            .opacity(isEventTypeAvailable(eventType: .food) ? 1.0 : 0.3)
                            
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.setSelectedEventType(eventType: .activity)
                                }
                            }) {
                                VStack(){
                                    Image("mira-1")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 118 ,height: 90)
                                        .cornerRadius(11)
                                        .shadow(radius: 5, x: 0, y: 2)
                                        .overlay(
                                            ZStack(){
                                                RoundedRectangle(cornerRadius: 11)
                                                    .fill(selectedEventType == .activity ? gradientSelected : gradientNozSelected)
        //                                            .stroke(gradient, lineWidth: 5)
                                                VStack() {
                                                    Spacer()
                                                    HStack() {
                                                        Spacer()
                                                        if selectedEventType == .activity {
                                                        Image(systemName: "checkmark")
                                                            .font(.system(size: 30, weight: .bold))
                                                            .foregroundColor(Color .white.opacity(0.8))
                                                            .padding()
                                                        }
                                                    }
                                                }
                                            }
                                        )
                                    
                                    Text("Entertainment")
                                    .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.semibold)
                                        .frame(width: 118)
                                        .allowsTightening(true)
                                        .lineLimit(1)
                                }
                            }
                            .disabled(!isEventTypeAvailable(eventType: .activity))
                            .buttonStyle(ListButtonStyle())
                            .opacity(isEventTypeAvailable(eventType: .activity) ? 1.0 : 0.3)
                            
                            
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.setSelectedEventType(eventType: .sport)
                                }
                            }) {
                                VStack(){
                                    Image("turtlerock")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 118 ,height: 90)
                                        .cornerRadius(11)
                                        .shadow(radius: 5, x: 0, y: 2)
                                        .overlay(
                                            ZStack(){
                                                RoundedRectangle(cornerRadius: 11)
                                                    .fill(selectedEventType == .sport ? gradientSelected : gradientNozSelected)
        //                                            .stroke(gradient, lineWidth: 5)
                                                VStack() {
                                                    Spacer()
                                                    HStack() {
                                                        Spacer()
                                                        if selectedEventType == .sport {
                                                        Image(systemName: "checkmark")
                                                            .font(.system(size: 30, weight: .bold))
                                                            .foregroundColor(Color .white.opacity(0.8))
                                                            .padding()
                                                        }
                                                    }
                                                }
                                            }
                                        )
                                    
                                    Text("Sport")
                                    .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.semibold)
                                        .frame(width: 118)
                                        .allowsTightening(true)
                                        .lineLimit(1)
                                }
                            }
                            .disabled(!isEventTypeAvailable(eventType: .sport))
                            .buttonStyle(ListButtonStyle())
                            .opacity(isEventTypeAvailable(eventType: .sport) ? 1.0 : 0.3)
                        }
                        .padding(.bottom, 20)
                        
                        HStack(){
                            Button(action: {
                                self.deleteGroupList()
                            }) {
                                Text("weiter")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.semibold)
                            }
                        }
                        .padding(.bottom, 20)

                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.bottom, 30)
                    .background(Color .white)
                    .transition(.move(edge: .top))
                    .cornerRadius(15)
//                    .shadow(color: Color ("DarkGray"), radius: 40, x: 0, y: 15)
                        .shadow(radius: 30, y: 10)
                }
            }
    }
    
}

struct ExploreCreateGroupView_Previews: PreviewProvider {
        @State static var pageIndex = 0 // Note: it must be static
        @State static var screenLock = false // Note: it must be static
        @State static var groupList = appUserData // Note: it must be static
        @State static var profiles = appUserData // Note: it must be static
        @State static var currentUserEventSelection : [EventType] = [.food, .activity] // Note: it must be static
        @State static var tempEventSelection : [EventType] = [.food, .activity] // Note: it must be static
        @State static var selectedEventType: EventType? = EventType.food // Note: it must be static
        
        static var previews: some View {
    //        ForEach(["iPhone SE (2nd generation)", "iPhone 11 Pro Max"], id: \.self) { deviceName in
                let userData = UserData()
                return ExploreCreateGroupView(
                    groupList: $groupList,
                    screenLock: $screenLock,
                    profiles: $profiles,
                    currentUserEventSelection: $currentUserEventSelection,
                    tempEventSelection: $tempEventSelection,
                    selectedEventType: $selectedEventType
                )
    //            .previewDevice(PreviewDevice(rawValue: deviceName))
    //            .previewDisplayName(deviceName)
                .environmentObject(userData)
    //        }
        }
    }
