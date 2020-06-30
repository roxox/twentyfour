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
    @Binding var isButtonBarHidden: Bool
    
    @State var showCard: Bool = false
    
        
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
//            userData.buttonBarOffset = CGFloat (0)
            isButtonBarHidden = false
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
                            VStack(alignment: .leading){
                                Text("Ausgewählte Personen")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.semibold)
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
                                                withAnimation(.linear(duration: 0.2)) {
                                                    self.removeFromGroupList(profile: profile)
                                                }
//                                                self.showCard.toggle()
                                            }) {
                                                VStack() {
                                                    profile.image
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(Circle())
                                                        .frame(width: 45 ,height: 45)
                                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                                    
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
//                                        .animation(.spring())
                                        }
//                                        .animation(.spring())
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
                            VStack(alignment: .leading) {
                                Text("Wähle eine Aktivität für die Gruppe")
                                .font(.avenirNextRegular(size: 20))
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
                                    imageString: "sport2",
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


