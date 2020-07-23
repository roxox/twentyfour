//
//  HomeProfileView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import UIKit
//import Combine

struct AppUserListView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var searchData: SearchData
    
    @Binding var selectedEventType: ActivityType?
    @Binding var groupList: [AppUser]
    @Binding var isButtonBarHidden: Bool
    @Binding var tmpValues: TemporaryGroupValues
    
    
    
    func removeFromGroupList(appUser: AppUser) {
        if self.groupList.contains(appUser) {
            self.groupList.remove(at: self.groupList.firstIndex(of: appUser)!)
            if self.groupList.count == 0 {
                isButtonBarHidden = false
            }
        }
    }
    
    func isEventTypeAvailable(eventType: ActivityType) -> Bool {
        
        if !searchData.eventTypes.contains(eventType){
            return false
        }
        
        for appUser in self.groupList {
            if !appUser.searchTypes.contains(eventType) {
                return false
            }
        }
        
        return true
    }
    
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    
                    ForEach(userData.appUsers) { appUser in
                        GeometryReader { geometryIn in
                            AppUserListItem(
                                appUser: appUser,
                                selectedEventType: self.$selectedEventType,
                                groupList: self.$groupList,
                                isButtonBarHidden: self.$isButtonBarHidden,
                                tmpValues: self.$tmpValues
                            )
                        }
                        .frame(width: 250, height: 320)
                    }
                }
                
            }
            .padding(.bottom, 15)
            .onTapGesture {
                hideKeyboard()
            }
            
            
            if self.groupList.count != 0  {
                Divider()
                
                Group {
                    // Headline ausgewähle User
                    HStack(){
                        VStack(alignment: .leading){
                            Text("1. Stelle dir eine Gruppe zusammen")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
//                                .foreground(gradientCherryPink)
                            
//                            Text("hier: \(String(session.settings!.showInfoTexts))")
                            if session.settings!.showInfoTexts {
                                HStack() {
                                    Text("Info: ")
                                        .font(.avenirNextRegular(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color ("button1"))
                                        +
                                        
                                        Text("Es sind \(self.groupList.count) Personen ausgewählt, die in die Gruppe eingeladen werden.")
                                        .font(.avenirNextRegular(size: 16))
                                        .fontWeight(.light)
//                                        .fixedSize(horizontal: false, vertical: false)
//                                        .lineLimit(3)
                                }
                                .padding(.top, 10)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    // ScrollView
                    ScrollView(.horizontal){
                        VStack(){
                            Spacer()
                                .frame(minWidth: 0, maxWidth: .infinity)
                            HStack(){
                                ForEach(self.groupList, id: \.self) { appUser in
                                    VStack(){
                                        HStack(){
                                            Button(action: {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    self.removeFromGroupList(appUser: appUser)
                                                }
                                            }) {
                                                VStack() {
                                                    appUser.image
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(Circle())
                                                        .frame(width: 60 ,height: 60)
                                                        .shadow(radius: 4, y: 2)
                                                    
                                                    Text(appUser.username)
                                                        .font(.avenirNextRegular(size: 12))
                                                        .fontWeight(.semibold)
                                                    
                                                }
                                                .foregroundColor(Color ("button1"))
                                            }
                                            
                                        }
                                    }
                                    //END: Zeilen Element pro ausgewähltem User
                                    
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 120)
                    //END: ScrollView
                    
                    
                    if session.settings!.showInfoTexts {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                    
                }
                .onTapGesture {
                    hideKeyboard()
                }
                // Group Ended
                
                Group {
                    // Headline EventType
                    HStack(){
                        VStack(alignment: .leading) {
                            Text("2. Wähle eine Aktivität für die Gruppe")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
//                                .foreground(gradientCherryPink)
                        }
                        
                        Spacer()
                        
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    
                    if session.settings!.showInfoTexts {
                        HStack() {
                            Text("Info: ")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color ("button1"))
                                +
                            Text("Auf Basis deiner Suchangaben und der Suchangaben deiner ausgewählten Personen, ergen sich folgende Aktivitäten, aus denen du eine für die Gruppe wählst.")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                    // END: Headline EventType
                    
                    
                    
                    // Selection EventType
                    HStack() {
                        if self.isEventTypeAvailable(eventType: .food) {
                            ActivityTypeButton(
                                searchData: self.searchData,
                                eventType: .food,
                                imageString: "moon.stars",
                                buttonTextString: "Essen und Trinken",
                                selectedEventType: self.$selectedEventType,
                                tmpValues: self.$tmpValues
                            )
                        }
                        
                        if self.isEventTypeAvailable(eventType: .leisure) {
                            ActivityTypeButton(
                                searchData: self.searchData,
                                eventType: .leisure,
                                imageString: "guitars",
                                buttonTextString: "Freizeit",
                                selectedEventType: self.$selectedEventType,
                                tmpValues: self.$tmpValues
                            )
                        }
                        
                        if self.isEventTypeAvailable(eventType: .sports) {
                            ActivityTypeButton(
                                searchData: self.searchData,
                                eventType: .sports,
                                imageString: "sportscourt",
                                buttonTextString: "Sport",
                                selectedEventType: self.$selectedEventType,
                                tmpValues: self.$tmpValues
                            )
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    
                    
                    if session.settings!.showInfoTexts {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                // Group 2 ENDED
                
                Group {
                    HStack() {
                        Text("3. Hier noch ein paar benötigte Informationen")
                            .font(.avenirNextRegular(size: 20))
                            .fontWeight(.semibold)
//                            .foreground(gradientCherryPink)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    
                    if session.settings!.showInfoTexts {
                        HStack() {
                            Text("Info: ")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color ("button1"))
                                +
                            Text("Es gibt nicht viele, aber zumindest einen Betreff bzw. einen Titel solltest du der Gruppe noch geben, damit andere Personen auch auf dem ersten Blick wissen, worum es geht.")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                    
                    
                    HStack(alignment: .top) {
                        Image(systemName: "pencil")
                            .font(.system(size: 18, weight: .semibold))
                            .fixedSize()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Titel")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.semibold)
                            TextField("Gib dem Ganzen einen Namen", text: $tmpValues.tmpTitleString)
                                .font(.avenirNextRegular(size: 18))
                            Divider()
                        }
                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    
                    HStack(alignment: .top) {
                        Image(systemName: "house")
                            .font(.system(size: 18, weight: .semibold))
                            .fixedSize()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Location")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.semibold)
                            TextField("Wo soll es hingehen?", text: $tmpValues.tmpLocationString)
                                .font(.avenirNextRegular(size: 18))
                            Divider()
                        }
                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    
                    if session.settings!.showInfoTexts {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                // Group 3 ENDED
                
                Group {
                    //
                    HStack() {
                        Text("4. Noch ein paar optionale Angaben... wenn du willst!")
                            .font(.avenirNextRegular(size: 20))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    if session.settings!.showInfoTexts {
                        HStack() {
                            Text("Info: ")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color ("button1"))
                                +
                            Text("Hast du z.B. von einem speziellen Restaurant gehört, dass du ausprobieren möchtest, dann gib es hier an. Alle Angabgen können auch später gemacht oder verändert werden.")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                    
                    HStack(alignment: .top) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 18, weight: .semibold))
                            .fixedSize()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Treffpunkt")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.semibold)
                            TextField("Wo kann man sich dort treffen?", text: $tmpValues.tmpMeetingString)
                                .font(.avenirNextRegular(size: 18))
                            Divider()
                        }
                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    
                    HStack(alignment: .top) {
                        Image(systemName: "alarm")
                            .font(.system(size: 18, weight: .semibold))
                            .fixedSize()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Zeitpunkt")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.semibold)
                            TextField("Wann wollt ihr euch treffen?", text: $tmpValues.tmpTimeString)
                                .font(.avenirNextRegular(size: 18))
                            Divider()
                        }
                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
                .onTapGesture {
                    hideKeyboard()
                }
                // Group 4 ENDED
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AppUserListItem: View {
    var appUser: AppUser
    
    @Binding var selectedEventType: ActivityType?
    @Binding var groupList: [AppUser]
    @Binding var isButtonBarHidden: Bool
    @Binding var tmpValues: TemporaryGroupValues
    
    func addToGroupList(appUser: AppUser) {
        if !self.groupList.contains(appUser) {
            self.groupList.append(appUser)
            if self.groupList.count >= 1 {
                isButtonBarHidden = true
            }
        }
    }
    
    func removeFromGroupList(appUser: AppUser) {
        if self.groupList.contains(appUser) {
            self.groupList.remove(at: self.groupList.firstIndex(of: appUser)!)
            if self.groupList.count == 0 {
                isButtonBarHidden = false
            }
        }
    }
    
    func resetGroupValues() {
        selectedEventType = nil
    }
    
    
    func didPressAddRemoveButton(appUser: AppUser) {
        if !self.groupList.contains(appUser) {
            addToGroupList(appUser: appUser)
        } else {
            removeFromGroupList(appUser: appUser)
            
            if self.groupList.count == 0 {
                resetGroupValues()
            }
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack(){
                self.appUser.image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: UIScreen.main.bounds.width*0.57 ,height: UIScreen.main.bounds.width*0.71)
            .overlay(AppUserTextOverlay(
                currentAppUser: self.appUser,
                selectedEventType: self.$selectedEventType,
                isButtonBarHidden: self.$isButtonBarHidden,
                tmpValues: self.$tmpValues,
                groupList: self.$groupList
            )
            )
            .cornerRadius(12)
            .shadow(radius: 7, y: 4)
            .padding(10)
        }
    }
}

struct AppUserTextOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var currentAppUser: AppUser
    @Binding var selectedEventType: ActivityType?
    
//    @Binding var groupList: [AppUser]
    @Binding var isButtonBarHidden: Bool
    @Binding var tmpValues: TemporaryGroupValues
    @Binding var groupList: [AppUser]
    
    func addToGroupList(appUser: AppUser) {
        if !self.groupList.contains(appUser) {
            self.groupList.append(appUser)
            if self.groupList.count >= 1 {
                isButtonBarHidden = true
            }
        }
    }
    
    func removeFromGroupList(appUser: AppUser) {
        if self.groupList.contains(appUser) {
            self.groupList.remove(at: self.groupList.firstIndex(of: appUser)!)
        }
        if self.groupList.count == 0 {
            isButtonBarHidden = false
        }
    }
    
    func resetGroupValues() {
        selectedEventType = nil
    }
    
    func didPressAddRemoveButton(appUser: AppUser) {
        if !self.groupList.contains(appUser) {
            addToGroupList(appUser: appUser)
        } else {
            removeFromGroupList(appUser: appUser)
            
            if self.groupList.count == 0 {
                resetGroupValues()
            }
        }
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.8), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
//    func getNumberOfMemberships(_ user: AppUser) -> Int {
//        return user.memberships.count
//    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                
                // Black Overlay
                
                VStack() {
                    
                    Spacer()
                    
                    HStack() {
                        VStack(alignment: .leading) {
                            Spacer()
                            
//                            NavigationLink(
//                                destination: CurrentAppUserDetailsView(
//                                    currentUser: currentAppUser
//                                )
//
//                            ) {
                                Text(self.currentAppUser.username)
                                    .foregroundColor(.white)
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.bold)
                                    .padding(.top)
                                    .padding(.horizontal)
//                            }
//                            .buttonStyle(BorderlessButtonStyle())
                            
                            HStack() {
                                
                                Text(self.currentAppUser.searchParameter.locationName)
                                    .foregroundColor(.white)
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.light)
                                    .padding(.leading)
                                
                                
//                                Text("\(currentAppUser.memberships.count)")
//                                    .foregroundColor(.white)
//                                    .font(.avenirNextRegular(size: 16))
//                                    .fontWeight(.light)
//                                    .padding(.leading)
                            }
                            .padding(.bottom, 10)
                        }
                        Spacer()
                        
                        VStack() {
                            //
                            Spacer()
                            
                            if self.groupList.contains(self.currentAppUser) {
                                
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.didPressAddRemoveButton(appUser: self.currentAppUser)
                                    }
                                }) {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 24, weight: .medium))
                                        .fixedSize()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                        .shadow(radius: 4, y: 2)
                                        .padding(.trailing, 15)
                                        .padding(.bottom, 15)
                                        .padding(.top, 10)
                                }
                            } else {
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.didPressAddRemoveButton(appUser: self.currentAppUser)
                                    }
                                }) {
                                    Image(systemName: "person.badge.plus.fill")
                                        .font(.system(size: 24, weight: .medium))
                                        .fixedSize()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                        .shadow(radius: 4, y: 2)
                                        .padding(.trailing, 15)
                                        .padding(.bottom, 15)
                                        .padding(.top, 10)
                                }
                            }
                        }
                    }
                    .background(self.gradient)
                }
            }
        }
    }
}
