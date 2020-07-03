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

struct ExploreGroupView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
     
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    
    @State var showProfile = false
    
    @State var page1 = 0
    var data1 = Array(0..<4)
    
    func pageView(_ group: UserGroup) -> some View {
        VStack(alignment: .leading) {
            group.image
//                Image("sport")
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*0.74 ,height: UIScreen.main.bounds.width*0.61)
//                    .frame(width: UIScreen.main.bounds.width*0.94 ,height: UIScreen.main.bounds.width*0.61)
                .overlay(GroupOverlay(
                    currentGroup: group,
                    selectedEventType: $selectedEventType,
                    groupList: $groupList,
                    showProfile: $showProfile
                    )
            )
            .cornerRadius(8)
                .shadow(radius: 7, y: 4)
        }
    .padding(10)
    }
    
    var body: some View {
        VStack() {
            
            
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {

                ForEach(userData.appGroups) { group in
                    GeometryReader { geometry in


                        NavigationLink(
                            destination: UserGroupDetail(
                                currentUserGroup: group
                            )

                        ) {
                            GroupRowItem(
                                group: group,
                                selectedEventType: self.$selectedEventType,
                                groupList: self.$groupList,
                                showProfile: self.$showProfile
                            )
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                    }
                    .frame(width: 320, height: 260)
                }
            }
            .padding(.bottom, 60)
        }
            
        Spacer()
        }
    }
}

struct GroupRowItem: View {
    var group: UserGroup
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                self.group.image
//                Image("sport")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.74 ,height: UIScreen.main.bounds.width*0.48)
                
                .cornerRadius(8)
                .shadow(radius: 4, y: 2)
                
                    HStack() {
                        VStack(alignment: .leading) {
                            Text(self.group.title!)
                                .foregroundColor(Color ("button1"))
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.semibold)
                            Text("Albertos Pizzeria, Los Angeles")
                                .foregroundColor(Color ("button1"))
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.light)
                            Text("3 Personen nehmen teil")
                                .foregroundColor(Color ("button1"))
                                .font(.avenirNextRegular(size: 16))
                                .fontWeight(.light)
                            Spacer()
                        }
                        Spacer()
                    }
                Spacer()
            }
        
        .padding(10)
    }
}

struct GroupOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var currentGroup: UserGroup
    @Binding var selectedEventType: EventType?
    
    @State var tempUser: Profile?
    @State var showInfoPanel: Bool = true
    @State var collapsedOffset: Int = 290
    
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    
    @State var showCard = false
    @State var userId: String = String()
    
    func getType(typeToTest: EventType) -> String{
        if typeToTest == .food {
            return "Essen und Trinken"
        }
        if typeToTest == .activity {
            return "Freizeit"
        }
        if typeToTest == .sport {
            return "Sport"
        }
        
        return ""
    }
    
    var body: some View {

        GeometryReader { geometry in
        ZStack(alignment: .bottomLeading) {
            
            // Black Overlay
            VStack() {
                
                Spacer()
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text(self.currentGroup.title!)
                            .foregroundColor(Color ("button1"))
                            .font(.avenirNextRegular(size: 17))
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.horizontal)
                        Text("Albertos Pizzeria, Los Angeles")
                            .foregroundColor(Color ("button1"))
                            .font(.avenirNextRegular(size: 13))
                            .fontWeight(.light)
                            .padding(.horizontal)
                        Text("3 Personen nehmen teil")
                            .foregroundColor(Color ("button1"))
                            .font(.avenirNextRegular(size: 13))
                            .fontWeight(.light)
                            .padding(.horizontal)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/3)
                    .background(Color ("background1"))
            }
            
            }
        }
    }
}

