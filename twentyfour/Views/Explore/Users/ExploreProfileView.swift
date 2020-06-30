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

struct ExploreProfileView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
    
    
    @GestureState private var isTapped = false
    @GestureState private var translation: CGFloat = 0
    @GestureState private var movement: CGFloat = 0
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    
    @State var showCard: Bool = false
     
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var tmpTitleString: String
    @Binding var tmpLocationString: String
    @Binding var tmpTimeString: String
    @Binding var tmpMeetingString: String
    @Binding var isButtonBarHidden: Bool
    
    
    @State var showProfile = false
    func addToGroupList(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    func didPressAddRemoveButton(profile: Profile) {
        if !groupList.contains(profile) {
            addToGroupList(profile: profile)
        } else {
            removeFromGroupList(profile: profile)

            if groupList.count == 0 {
                resetGroupValues()
            }
        }
    }
    
    func isEventTypeAvailable(eventType: EventType) -> Bool {
        
        if !searchDataContainer.eventTypes.contains(eventType){
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
        VStack {
            
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {

                ForEach(userData.appUsers) { profile in
                    GeometryReader { geometry in
                        RowItem(
                            profile: profile,
                            selectedEventType: self.$selectedEventType,
                            groupList: self.$groupList,
                            showProfile: self.$showProfile,
                            isButtonBarHidden: self.$isButtonBarHidden
                        )
                    }
                    .frame(width: 244, height: 320)
                }
            }

        }
        .padding(.bottom, 15)
        .onTapGesture {
            hideKeyboard()
        }
            
            
            
        if groupList.count != 0  {
            Divider()
            
            Group {
        // Headline ausgewähle User
            HStack(){
                VStack(alignment: .leading){
                    Text("Ausgewählte Personen")
                    .font(.avenirNextRegular(size: 20))
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(1)
                    
                    
                    Text("Es sind \(self.groupList.count) Personen ausgewählt, die in die Gruppe eingeladen werden.")
                    .font(.avenirNextRegular(size: 16))
                    .fontWeight(.light)
                            .fixedSize(horizontal: false, vertical: false)
                            .lineLimit(3)
                }

                Spacer()

            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 10)
//            }
            
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
                                        withAnimation(.linear(duration: 0.2)) {
                                            self.removeFromGroupList(profile: profile)
                                        }
                                    }) {
                                        VStack() {
                                            profile.image
                                                .renderingMode(.original)
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(Circle())
                                                .frame(width: 45 ,height: 45)
                                                .overlay(Circle().stroke(gradientBlueAccentSea, lineWidth: 1))
                                            
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
                                }
                                //END: Zeilen Element pro ausgewähltem User

                            }
                        }
                        }
                    .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        .animation(nil)
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 120)
                .animation(nil)
                //END: ScrollView
                
                Divider()
            
            }
            .onTapGesture {
                hideKeyboard()
            }
            // Group Ended
            
            Group {
            // Headline EventType
            HStack(){
                VStack(alignment: .leading) {
                    Text("Wähle eine Aktivität für die Gruppe")
                    .font(.avenirNextRegular(size: 20))
                        .fontWeight(.medium)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(1)
                }

                Spacer()

            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 10)
                
                HStack() {
                        Text("Auf Basis deiner Suchangaben und der Suchangaben deiner ausgewählten Personen, ergen sich folgende Aktivitäten, aus denen du eine für die Gruppe wählst.")
                        .font(.avenirNextRegular(size: 16))
                            .fontWeight(.light)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            // END: Headline EventType
            
            
            
            // Selection EventType
            HStack() {
                if self.isEventTypeAvailable(eventType: .food) {
                    EventTypeSelectorButton(
                        searchData: self.searchDataContainer,
                        eventType: .food,
                        imageString: "essen",
                        buttonTextString: "Essen und Trinken",
                        selectedEventType: self.$selectedEventType,
                        groupList: self.$groupList
                    )
                }

                if self.isEventTypeAvailable(eventType: .activity) {
                    EventTypeSelectorButton(
                        searchData: self.searchDataContainer,
                        eventType: .activity,
                        imageString: "freizeit2",
                        buttonTextString: "Freizeit",
                        selectedEventType: self.$selectedEventType,
                        groupList: self.$groupList
                    )
                }

                if self.isEventTypeAvailable(eventType: .sport) {
                    EventTypeSelectorButton(
                        searchData: self.searchDataContainer,
                        eventType: .sport,
                        imageString: "sport2",
                        buttonTextString: "Sport",
                        selectedEventType: self.$selectedEventType,
                        groupList: self.$groupList
                    )
                }

            }
            .padding(.top, 10)
            
            
            Divider()
                
            }
            .onTapGesture {
                hideKeyboard()
            }
            // Group 2 ENDED
            
            Group {
                HStack() {
                    Text("Pflichtangaben")
                    .font(.avenirNextRegular(size: 20))
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                HStack() {
                        Text("Es gibt nicht viele, aber zumindest einen Betreff bzw. einen Titel solltest du der Gruppe noch geben, damit andere Personen auch auf dem ersten Blick wissen, worum es geht.")
                        .font(.avenirNextRegular(size: 16))
                            .fontWeight(.light)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            

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
                    TextField("Gib dem Ganzen einen Namen", text: self.$tmpTitleString)
                        .font(.avenirNextRegular(size: 18))
//                                .offset(y: 5)
//                        .onTapGesture {
//                            self.isFocused = true
//                        }
                    Divider()
                }
                .padding(.trailing, 40)

                    Spacer()
                }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 20)

            Divider()
            }
            .onTapGesture {
                hideKeyboard()
            }
            // Group 3 ENDED
            
            Group {
//
            HStack() {
                    Text("Optionale Angaben")
                    .font(.avenirNextRegular(size: 20))
                        .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
                
            HStack() {
                    Text("Hast du z.B. von einem speziellen Restaurant gehört, dass du ausprobieren möchtest, dann gib es hier an. Alle Angabgen können auch später gemacht oder verändert werden.")
                    .font(.avenirNextRegular(size: 16))
                        .fontWeight(.light)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

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
                    TextField("Wo soll es hingehen?", text: self.$tmpLocationString)
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
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 18, weight: .semibold))
                    .fixedSize()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text("Treffpunkt")
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                    TextField("Wo kann man sich dort treffen?", text: self.$tmpMeetingString)
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
                    TextField("Wann wollt ihr euch treffen?", text: self.$tmpTimeString)
                        .font(.avenirNextRegular(size: 18))
                    Divider()
                }
                .padding(.trailing, 40)

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
            
            Divider()
                .padding(.bottom, 20)
            }
            .onTapGesture {
                hideKeyboard()
            }
            // Group 4 ENDED
            }
            
        Spacer()
        }
    }
}

struct RowItem: View {
    var profile: Profile
    
    @State var scaler: CGFloat = 1.0
    
    @GestureState private var isTapped = false
    @GestureState private var translation: CGFloat = 0
    @GestureState private var movement: CGFloat = 0
    
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    @Binding var isButtonBarHidden: Bool
    
    func addToGroupList(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    
    func didPressAddRemoveButton(profile: Profile) {
        if !groupList.contains(profile) {
            addToGroupList(profile: profile)
        } else {
            removeFromGroupList(profile: profile)

            if groupList.count == 0 {
                resetGroupValues()
            }
        }
    }
    
    func setScaler(scale: CGFloat) {
        print(scale)
        scaler = scale
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(){
                    self.profile.image
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                }
                .frame(width: UIScreen.main.bounds.width*0.55 ,height: UIScreen.main.bounds.width*0.67)
//                    .frame(width: UIScreen.main.bounds.width*0.55 ,height: UIScreen.main.bounds.width*0.73)
                .overlay(AppUserTextOverlay(
                    currentProfile: self.profile,
                    selectedEventType: self.$selectedEventType,
                    groupList: self.$groupList,
                    showProfile: $showProfile,
                    isButtonBarHidden: self.$isButtonBarHidden
                    )
                )
                .cornerRadius(15)
                .shadow(radius: 7, y: 4)
                .scaleEffect(self.isTapped ? 0.95 : 1.0)
                
                // NICHT LÖSCHEN
                // WICHTIG FÜR DAS VERKLEINERN BEIM BERÜHREN, FEHLFUNKTION AUF SCROLLVIEW
//                .simultaneousGesture(
//                    DragGesture(minimumDistance: 0).updating(self.$isTapped) { value, isTapped, _ in
//                        isTapped = true
//                    }
//            )
                // NICHT LÖSCHEN ENDE
                    
                    
        .padding(10)
        }
    }
}

struct AppUserTextOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var currentProfile: Profile
    @Binding var selectedEventType: EventType?
    
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    @Binding var isButtonBarHidden: Bool
    
    @State var showCard = false
        
    func addToGroupList(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
            if groupList.count == 1 {
                isButtonBarHidden = true
            }
        }
    }
    
    func removeFromGroupList(profile: Profile) {
        if groupList.contains(profile) {
            groupList.remove(at: groupList.firstIndex(of: profile)!)
        }
        if groupList.count == 0 {
            isButtonBarHidden = false
        }
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    func didPressAddRemoveButton(profile: Profile) {
        if !groupList.contains(profile) {
            addToGroupList(profile: profile)
        } else {
            removeFromGroupList(profile: profile)

            if groupList.count == 0 {
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
    
    var body: some View {

        GeometryReader { geometry in
        ZStack(alignment: .bottomLeading) {
            
            // Black Overlay
            
            VStack() {
                
                Spacer()
                
                HStack() {
                    VStack(alignment: .leading) {
                        Spacer()
                        
                       NavigationLink(
                        destination: UserDetailsView(
                            currentUser: currentProfile
                        )

                       ) {
                           Text(self.currentProfile.username)
                               .foregroundColor(Color ("button1_inverted"))
                               .font(.avenirNextRegular(size: 17))
                               .fontWeight(.bold)
                               .padding(.top)
                               .padding(.horizontal)
                       }
                       .buttonStyle(BorderlessButtonStyle())

                        HStack() {

                            Text(self.currentProfile.searchParameter.locationName)
                                .foregroundColor(Color ("button1_inverted"))
                                .font(.avenirNextRegular(size: 13))
                                .fontWeight(.light)
                                .padding(.leading)
                        }
                        .padding(.bottom, 10)
                    }
                    Spacer()
                    
                    VStack() {
//
                        Spacer()

                        if self.groupList.contains(self.currentProfile) {
                            
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.didPressAddRemoveButton(profile: self.currentProfile)
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
                                    self.didPressAddRemoveButton(profile: self.currentProfile)
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


struct HeaderSectionView: View {
    
    @EnvironmentObject var userData: UserData
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var tmpTitleString: String
    @Binding var tmpLocationString: String
    @Binding var tmpTimeString: String
    @Binding var tmpMeetingString: String
    @Binding var isButtonBarHidden: Bool

        
        func deleteGroupList() {
            groupList.removeAll()
            resetGroupValues()
            
            if groupList.count != 0 {
                isButtonBarHidden = true
            } else {
                isButtonBarHidden = false
            }
        }
        
        func resetGroupValues() {
            selectedEventType = nil
            tmpTitleString = ""
            tmpTimeString = ""
            tmpMeetingString = ""
            tmpLocationString = ""
        }
    
    func getActivityString(eventType: EventType) -> String {
        switch eventType {
        case .food:
            return "Essen und Trinken"
        case .activity:
            return "Freizeit"
        case .sport:
            return "Sport"
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(){
                VStack(){
                    Rectangle().fill(Color ("background1"))
                            .frame(height: geometry.safeAreaInsets.top)
                    ZStack() {
                        HStack(){
                            Button(action: {
                                self.deleteGroupList()
                            }) {
                                HStack(){

                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 14, height: 14)
                                    }
                                
                                    .foregroundColor(Color ("button1"))
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 20)
                            
            //            .padding(.top, 12)
                        HStack(alignment: .center){
                            Spacer()
                            Text("Neue Gruppe")
                            .font(.avenirNextRegular(size: 15))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                        Divider()
                }
                .background(Color ("background1"))
                
                Spacer()
                
                VStack() {
                    
                    Divider()
                    
                    HStack() {
                        
                        VStack(alignment: .leading){
                            if tmpTitleString != "" {
                                Text(tmpTitleString)
                                    .font(.avenirNextRegular(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color ("button1"))
                            } else {
                                Text(tmpTitleString != "" ? tmpTitleString : "Gib der Gruppe noch einen Titel")
                                    .font(.avenirNextRegular(size: 12))
                                    .fontWeight(.semibold)
                                    .foreground(gradientCherryPink)
                            }
                            HStack() {
                            Text("\(groupList.count) Personen")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.medium)
                            Text("•")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.medium)
                                
                            if selectedEventType != nil {
                                Text(self.getActivityString(eventType: selectedEventType!))
                                    .font(.avenirNextRegular(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color ("button1"))
                            } else {
                                Text("Wähle noch eine Aktivität aus")
                                    .font(.avenirNextRegular(size: 12))
                                    .fontWeight(.medium)
                                    .foreground(gradientCherryPink)
                            }
                            }
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
        //                        self.searchDataContainer.extendTimer()
                            }
                        }) {
                            HStack() {
                                Text("erstellen")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color ("button1_inverted"))
                                    .padding(.horizontal)
                            }
                            .frame(height: 40)
                            .background(gradientPeachPink)
    //                        .background(Color ("RedPeach"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .saturation(self.selectedEventType != nil && self.groupList.count != 0 && self.tmpTitleString != "" ? 1 : 0.2)
                        .opacity(self.selectedEventType != nil && self.groupList.count != 0 && self.tmpTitleString != "" ? 1 : 0.2)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)

                    }
                    
                }
                .background(Color ("background1"))
            }
            .edgesIgnoringSafeArea(.top)
        }
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
                        .lineLimit(2)
                }
            }.animation(nil)
            .foregroundColor(Color ("button1"))
                .disabled(!isEventTypeAvailable(eventType: eventType))
                .saturation(selectedEventType == eventType ? 1.0 : 0.0)
                .buttonStyle(BorderlessButtonStyle())
    }
}
