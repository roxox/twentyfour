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
    
    @State var tapped = false
    
    func tappedRec(){
        tapped = !tapped
    }
    
    
    func addToGroupList(_ appUser: AppUser) {
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
            HStack() {
                Text("Finde neue Freunde und gründe neue Gruppen")
                    .font(.avenirNextRegular(size: 22))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .padding(.horizontal, 26)
                Spacer()
            }
            .padding(.top, 120)
            .padding(.bottom, 6)
            
            HStack() {
                Text("Egal ob zugezogen, auf Dienstreise oder nur so noch ohne Freunde, hier findest du bestimmt Gleichgesinnte.")
                    .font(.avenirNextRegular(size: 16))
                    .lineLimit(5)
                    .padding(.horizontal, 26)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    
                    ForEach(userData.appUsers) { appUser in
                        
                        Button(action: {
                            //                            withAnimation(.linear(duration: 0.2)) {
                            self.addToGroupList(appUser)
                            //                            }
                        }) {
                            AppUserListItem(
                                appUser: appUser,
                                selectedEventType: self.$selectedEventType,
                                groupList: self.$groupList,
                                isButtonBarHidden: self.$isButtonBarHidden,
                                tmpValues: self.$tmpValues
                            )
                        }
                        .frame(width: 167, height: 233)
                    }
                    .padding(.trailing, 5)
                }
                .padding(.horizontal, 26)
                
            }
            .onTapGesture {
                hideKeyboard()
            }
            
            ZStack(){
                HStack(){
                    Image(systemName: "person.fill.badge.plus")
                        .font(.system(size: 33, weight: .medium))
                        .foregroundColor(Color("dark_gray"))
                        .fixedSize()
                        .frame(width: 70, height: 70)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 3,
                                        dash: [11]
                                    )
                                )
                                .foregroundColor(Color("dark_gray"))
                        )
                    
                    Text("Lade deine Freunde ein, damit auch in deiner Gruppe sein können.")
                        .lineLimit(5)
                        .font(.avenirNextRegular(size: 16))
                        .padding(.leading, 24)
                    Spacer()
                }.padding(14)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color("bright_gray"))
            .cornerRadius(10)
            .padding(26)
            
            
            if self.groupList.count != 0  {
                //                Divider()
                
                Group {
                    // Headline ausgewähle User
                    HStack(alignment: .top, spacing: 0){
                        VStack(alignment: .leading){
                            Text("Wähle Gruppenmitglieder aus ")
                                .font(.avenirNextRegular(size: 16))
                                +
                                Text("(benötigt)")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.medium)
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
                                }
                                .padding(.top, 10)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    // ScrollView
                    ScrollView(.vertical){
                        VStack(){
                            Spacer()
                                .frame(minWidth: 0, maxWidth: .infinity)
                            VStack(){
                                ForEach(self.groupList, id: \.self) { appUser in
                                    VStack(){
                                        HStack(){
                                            Button(action: {
                                                //                                                withAnimation(.linear(duration: 0.2)) {
                                                self.removeFromGroupList(appUser: appUser)
                                                //                                                }
                                            }) {
                                                HStack() {
                                                    appUser.image
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(Circle())
                                                        .frame(width: 40 ,height: 40)
                                                        .shadow(radius: 7, y: 2)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(appUser.username)
                                                            .font(.avenirNextRegular(size: 16))
                                                            .fontWeight(.medium)
                                                        Text(appUser.searchParameter.locationName)
                                                            .font(.avenirNextRegular(size: 16))
                                                    }
                                                    Spacer()
                                                    Text("entfernen")
                                                        .font(.avenirNextRegular(size: 18))
                                                        .foreground(gradientPinkOrange)
                                                        .padding(.trailing, 10)
                                                    
                                                }
                                                .foregroundColor(Color ("button1"))
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    Divider()
                        .padding(.horizontal, 20)
                    //                    }
                    
                }
                .onTapGesture {
                    hideKeyboard()
                }
                // Group Ended
                
                Group {
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
                        //                        Image(systemName: "pencil")
                        //                            .font(.system(size: 18, weight: .semibold))
                        //                            .fixedSize()
                        //                            .frame(width: 30, height: 30)
                        //                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Titel ")
                                .font(.avenirNextRegular(size: 16))
                                //                                .fontWeight(.light)
                                +
                                Text("(benötigt)")
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.medium)
                            TextField("Gib dem Ganzen einen Namen", text: $tmpValues.tmpTitleString)
                                .font(.avenirNextRegular(size: 20))
                            Divider().padding(.top)
                        }
                        //                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    //                    .padding(.bottom, 20)
                    
                    HStack(alignment: .top) {
                        //                        Image(systemName: "house")
                        //                            .font(.system(size: 18, weight: .semibold))
                        //                            .fixedSize()
                        //                            .frame(width: 30, height: 30)
                        //                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            HStack() {
                                Text("Ort ")
                                    .font(.avenirNextRegular(size: 16))
                                //                                .fontWeight(.light)
                                //                                +
                                //                                Text("(benötigt)")
                                //                                    .font(.avenirNextRegular(size: 14))
                                //                                    .fontWeight(.bold)
                                
                                Spacer()
                                Text("ändern")
                                    .font(.avenirNextRegular(size: 18))
                                    //                                    .fontWeight(.medium)
                                    //                                    .foregroundColor(Color ("DarkGreen"))
                                    .foreground(gradientPinkOrange)
                                    //                                    .foregroundColor(Color .pink)
                                    
                                    .padding(.trailing, 10)
                            }
                            TextField("Wo soll es hingehen?", text: $tmpValues.tmpLocationString)
                                .font(.avenirNextRegular(size: 20))
                            Divider().padding(.top)
                            //                                .padding(.bottom, 10)
                        }
                        //                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    //                    .padding(.bottom, 20)
                    
                    //                    if session.settings!.showInfoTexts {
                    //                        Divider()
                    //                            .padding(.horizontal, 20)
                    //                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                // Group 3 ENDED
                
                Group {
                    //
                    //                    HStack(alignment: .top, spacing: 0) {
                    //
                    ////                        Image(systemName: "4.circle")
                    ////                            .font(.system(size: 30, weight: .light))
                    ////                            .fixedSize()
                    ////                            .frame(width: 30, height: 30)
                    ////                            .padding(.trailing, 5)
                    ////                            .foreground(gradientCherryPink)
                    //
                    ////                        Text("4. ")
                    ////                            .font(.avenirNextRegular(size: 20))
                    ////                            .fontWeight(.semibold)
                    ////                            .fixedSize(horizontal: false, vertical: true)
                    ////                            .lineLimit(1)
                    //
                    ////                        Spacer()
                    ////                        Text("Optional")
                    ////                            .font(.avenirNextRegular(size: 18))
                    ////                            .fontWeight(.semibold)
                    ////                            .padding(.bottom)
                    ////                        Spacer()
                    //                    }
                    //                    .padding(.horizontal, 20)
                    //                    .padding(.top, 10)
                    
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
                        //                        Image(systemName: "mappin.and.ellipse")
                        //                            .font(.system(size: 18, weight: .semibold))
                        //                            .fixedSize()
                        //                            .frame(width: 30, height: 30)
                        //                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            HStack() {
                                Text("Beschreibung")
                                    .font(.avenirNextRegular(size: 16))
                                //                                .fontWeight(.light)
                                
                                Spacer()
                                Text("hinzufügen")
                                    .font(.avenirNextRegular(size: 18))
                                    //                                    .fontWeight(.medium)
                                    //                                                                        .foregroundColor(Color ("DarkGreen"))
                                    //                                                                        .foreground(gradientCherryPink)gradientPinkOrange
                                    .foreground(gradientPinkOrange)
                                    .padding(.trailing, 10)
                            }
                            //                            TextField("Wo kann man sich dort treffen?", text: $tmpValues.tmpMeetingString)
                            //                                .font(.avenirNextRegular(size: 20))
                            
                            Divider().padding(.top)
                        }
                        //                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    //                    .padding(.bottom, 20)
                    
                    HStack(alignment: .top) {
                        //                        Image(systemName: "alarm")
                        //                            .font(.system(size: 18, weight: .semibold))
                        //                            .fixedSize()
                        //                            .frame(width: 30, height: 30)
                        //                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Zeitpunkt")
                                .font(.avenirNextRegular(size: 16))
                            //                                .fontWeight(.light)
                            TextField("Wann wollt ihr euch treffen?", text: $tmpValues.tmpTimeString)
                                .font(.avenirNextRegular(size: 20))
                            Divider().padding(.top)
                            //                                .padding(.bottom, 10)
                        }
                        //                        .padding(.trailing, 40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    //                    Divider()
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
        ZStack() {
            HStack(){
                self.appUser.image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 167, height: 233)
            .overlay(AppUserTextOverlay(
                currentAppUser: self.appUser,
                selectedEventType: self.$selectedEventType,
                isButtonBarHidden: self.$isButtonBarHidden,
                tmpValues: self.$tmpValues,
                groupList: self.$groupList
            )
            )
            .cornerRadius(10)
            //            .shadow(radius: 5, y: 2)
            .padding(4)
            
        }
        .padding(20)
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
                gradient
                VStack() {
                    
                    
                    Spacer()
                    
                    HStack() {
                        Text("\(self.currentAppUser.username)")
                            .foregroundColor(.white)
                            .font(.avenirNextRegular(size: 21))
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .padding(.leading, 12)
                        Spacer()
                    }
                    HStack() {
                        Text("\(self.currentAppUser.searchParameter.locationName)")
                            .foregroundColor(.white)
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .padding(.leading, 12)
                            .padding(.bottom, 12)
                        Spacer()
                    }
                }
            }
        }
    }
}
